import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmap/presentation/manager/controller/home_Controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.from, required this.to});
  final String from;
  final String to;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Obx(() {
      return GoogleMap(
        onMapCreated: homeController.onMApCreated,
        initialCameraPosition: CameraPosition(target: LatLng(20.5937, 78.9629),zoom: 5.0),
        polylines: homeController.polyLines.value,
      );
    })));
  }
}
