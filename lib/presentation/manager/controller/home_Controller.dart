import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmap/core/response_classify.dart';
import 'package:gmap/data/remote/modals/request/Gmap_RequestModal.dart';
import 'package:gmap/data/remote/modals/response/GMap_ResponseModal.dart'
    as gMapRes;
import 'package:gmap/data/remote/modals/response/formRes.dart';
import 'package:gmap/domain/usecase/formUsecase.dart';
import 'package:gmap/presentation/manager/bindings/home_Binding.dart';
import 'package:gmap/presentation/pages/map_page.dart';
import 'package:gmap/presentation/themes/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import '../../../domain/usecase/getRote_UseCase.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  final GetRouteUseCase getRouteUseCase;
  late GoogleMapController googleMapController;
  final FormUsecase formUsecase;
  var polyLines = Set<Polyline>().obs;
  final LatLng center = const LatLng(20.5937, 78.9629);
  HomeController(
    this.getRouteUseCase,
    this.formUsecase,
  );

  @override
  void onInit() {
    requestLocationPermission();

    super.onInit();
  }

  final getRouteState =
      ResponseClassify<gMapRes.GmapResponseModel>.error("").obs;
  getroute(String from, to) async {
    getRouteState.value = ResponseClassify.loading();
    try {
      debugPrint("success==success0");

      getRouteState.value = ResponseClassify.completed(
          await getRouteUseCase.call(GmapRequestModal(from, to)));
      debugPrint("success==success1");

      final points =
          getRouteState.value.data!.routes.first.overviewPolyline.points;
      final polyline = decodePoly(points);
      polyLines.add(Polyline(
          polylineId: PolylineId("route"),
          visible: true,
          points: polyline,
          color: AppColors.blue,
          width: 5));
      debugPrint("success==success2");

      Get.to(
        () => MapPage(
          from: fromController.text,
          to: toController.text,
        ),
        binding: HomeBinding(),
      );
      debugPrint("success==success3");
    } catch (e) {
      getRouteState.value = ResponseClassify.error("$e");
      Get.defaultDialog(
          title: "Failed",
          content: Text("${getRouteState.value.error}"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Try Again"))
          ]);
      debugPrint("error==$e");
    }
  }

  void onMApCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  List<LatLng> decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = <double>[];
    int index = 0;
    int len = poly.length;
    int c = 0;

    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);

      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    List<LatLng> polyLatLng = [];
    for (var i = 0; i < lList.length; i += 2) {
      polyLatLng.add(LatLng(lList[i], lList[i + 1]));
    }
    return polyLatLng;
  }

  ///use location showing

  var currentLocation = Rxn<Position>(); // Use Position type

  var gMapController = Rxn<GoogleMapController>();
  var isLoading = true.obs;

  void requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Request to enable location service if disabled
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Handle the case where location permission is permanently denied
        print('Location permission is permanently denied');
      } else if (permission == LocationPermission.denied) {
        // Request permission again if initially denied
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always) {
          // Handle if permission is still denied after requesting again
          print('Location permission is still denied');
        }
      }
    }

    // Check location permission status
    permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.denied) {
      // Request location permission if denied
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted != LocationPermission.always) {
        return; // Handle if permission is not granted
      }
    }

    // Get current location
    try {
      currentLocation.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best, // Adjust accuracy if needed
      );
      isLoading.value = false;
    } catch (error) {
      // Handle location retrieval errors
      print('Error getting location: $error');
    }

    // Listen for location updates
    Geolocator.getPositionStream().listen((Position location) {
      currentLocation.value = location;
      updateCameraPosition();
    });
  }

  void updateCameraPosition() {
    if (gMapController.value != null && currentLocation.value != null) {
      gMapController.value!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            currentLocation.value!.latitude!,
            currentLocation.value!.longitude!,
          ),
          zoom: 5, // Adjust zoom level as needed
        ),
      ));
    }
  }

  final imagePicker = ImagePicker();
  var androidlogoImg = Rxn<File>();
  var selectedWebLogo = Uint8List(0).obs;
  Future<void> pickImage() async {
    final imagepickedfile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagepickedfile != null) {
      if (kIsWeb) {
        final XFile? image = imagepickedfile;
        if (image != null) {
          var webLogoFile = await image.readAsBytes();
          selectedWebLogo.value = webLogoFile;
          androidlogoImg.value = File("");
        } else {
          print("No Image selected");
        }
      } else {
        final XFile? image = imagepickedfile;
        if (image != null) {
          final androidLogoFile = File(image.path);
          androidlogoImg.value = androidLogoFile;
          selectedWebLogo.value.clear();
        } else {
          print("No Image selected");
        }
      }
    }
  }

  final TextEditingController companyNameCntrl = TextEditingController();
  final TextEditingController companyEmailCntrl = TextEditingController();
  final TextEditingController websiteCntrl = TextEditingController();

  final formResponse = ResponseClassify<FormResponse>.error("").obs;
  uplodForm(String companyName, companyEmail, website, logimage) async {
    formResponse.value = ResponseClassify.loading();
    try {
      dio.FormData data = dio.FormData();
      var logo;
      if (logimage != null) {
        logo = dio.MultipartFile.fromBytes(logimage,
            filename: 'logoj.jpg', contentType: MediaType('image', 'jpg'));
      }
      debugPrint("logo==${logo.length}");
      var formData = dio.FormData.fromMap({
        'companyName': companyName,
        'companyEmail': companyEmail,
        'website': website,
        'logo': logo,
      });
      formResponse.value =
          ResponseClassify.completed(await formUsecase.call(formData));
      print("success");
    } catch (e) {
      formResponse.value = ResponseClassify.error("$e");
      print("error ==$e");
    }
  }
}
