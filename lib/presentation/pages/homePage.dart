import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gmap/core/response_classify.dart';
import 'package:gmap/presentation/manager/bindings/home_Binding.dart';
import 'package:gmap/presentation/manager/controller/home_Controller.dart';
import 'package:gmap/presentation/pages/map_page.dart';
import 'package:gmap/presentation/themes/app_colors.dart';
import 'dart:math' as math;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: Text(
          "Journey",
          style: TextStyle(
              color: AppColors.white,
              fontSize: w * 0.08,
              fontWeight: FontWeight.bold),
        ),
        bottom: AppBar(
          toolbarHeight: kToolbarHeight + h * 0.20,
          elevation: 0,
          backgroundColor: AppColors.darkBlue,
          title: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///From
                  TextFormField(
                    controller: homeController.fromController,
                    cursorColor: AppColors.white.withOpacity(0.5),
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.7),
                    ),
                    decoration: InputDecoration(
                      hintText: "From",
                      hintStyle: TextStyle(
                        color: AppColors.white.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        CommunityMaterialIcons.ray_start_arrow,
                        color: AppColors.white.withOpacity(0.5),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();

                          homeController.fromController.clear();
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColors.white.withOpacity(0.5),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.white.withOpacity(0.5),
                              width: w * 0.02)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: AppColors.white.withOpacity(0.5),
                      )),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: AppColors.red,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.white.withOpacity(0.5))),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.white.withOpacity(0.5))),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.025,
                  ),

                  ///TO
                  TextFormField(
                    controller: homeController.toController,
                    cursorColor: AppColors.white.withOpacity(0.5),
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.7),
                    ),
                    decoration: InputDecoration(
                      hintText: "To",
                      hintStyle: TextStyle(
                        color: AppColors.white.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        CommunityMaterialIcons.ray_start_end,
                        color: AppColors.white.withOpacity(0.5),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          homeController.toController.clear();
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColors.white.withOpacity(0.5),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.white.withOpacity(0.5),
                              width: w * 0.02)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: AppColors.white.withOpacity(0.5),
                      )),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: AppColors.red,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.white.withOpacity(0.5))),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.white.withOpacity(0.5))),
                    ),
                  ),

                  SizedBox(
                    height: h * 0.025,
                  ),

                  ///Button
                  SizedBox(
                    height: h * 0.055,
                    width: w,
                    child: Obx(
                      () => homeController.getRouteState.value.status ==
                              Status.LOADING
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                if (homeController
                                        .fromController.text.isEmpty &&
                                    homeController.toController.text.isEmpty) {
                                  Get.snackbar("Failed",
                                      "Please Enter your Starting and Destination");
                                } else if (homeController
                                    .fromController.text.isEmpty) {
                                  Get.snackbar(
                                      "Failed", "Please Enter your Starting ");
                                } else if (homeController
                                    .toController.text.isEmpty) {
                                  Get.snackbar("Failed",
                                      "Please Enter your Destination");
                                } else {
                                  homeController.getroute(
                                      homeController.fromController.text,
                                      homeController.toController.text);
                                }
                              },
                              child: Text(
                                "Find Route",
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  foregroundColor: AppColors.white,
                                  textStyle: TextStyle(fontSize: w * 0.04),
                                  backgroundColor: AppColors.green),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.0001,
                  ),
                ],
              ),

              ///Change Icon
              Positioned(
                top: h * 0.046,
                right: w * 0.12,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white.withOpacity(0.5)),
                  ),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(math.pi / 2),
                    child: IconButton(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        String to = homeController.toController.text;
                        String from = homeController.fromController.text;
                        homeController.fromController.text = to;
                        homeController.toController.text = from;
                      },
                      icon: Icon(Icons.compare_arrows_outlined,
                          color: AppColors.white.withOpacity(0.5)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (homeController.currentLocation.value == null) {
          return Center(
            child: Text("Unable to fetch location"),
          );
        } else {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(homeController.currentLocation.value!.latitude!,
                  homeController.currentLocation.value!.latitude!),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              homeController.gMapController.value = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        }
      }),
    ));
  }
}
