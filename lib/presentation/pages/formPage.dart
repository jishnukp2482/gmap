import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmap/presentation/manager/controller/home_Controller.dart';
import 'package:gmap/presentation/themes/app_colors.dart';

class CreateNewCompany extends StatefulWidget {
  const CreateNewCompany({super.key});

  @override
  State<CreateNewCompany> createState() => _CreateNewCompanyState();
}

class _CreateNewCompanyState extends State<CreateNewCompany> {
  final dashboardCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "ADD NEW COMPANY",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.cardLightGrey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: dashboardCtrl.companyNameCntrl,
                            decoration: InputDecoration(
                              labelText: "Company Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.02),
                            child: TextFormField(
                              controller: dashboardCtrl.companyEmailCntrl,
                              decoration: InputDecoration(
                                labelText: "Company E-Mail ID",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    dashboardCtrl.pickImage();
                                  },

                                  ///Method 1
                                  child: Obx(() {
                                    if (dashboardCtrl
                                                .androidlogoImg.value?.path !=
                                            null ||
                                        dashboardCtrl
                                            .selectedWebLogo.value.isNotEmpty) {
                                      return Text('Change Logo');
                                    } else {
                                      return Text("Select Logo");
                                    }
                                  }),
                                ),
                                Obx(() {
                                  if (dashboardCtrl
                                              .androidlogoImg.value?.path !=
                                          null ||
                                      dashboardCtrl
                                          .selectedWebLogo.value.isNotEmpty) {
                                    return Container(
                                        width: 70,
                                        height: 70,
                                        child: kIsWeb
                                            ? Image.memory(
                                                dashboardCtrl
                                                    .selectedWebLogo.value,
                                                fit: BoxFit.cover)
                                            : Image.file(
                                                dashboardCtrl
                                                    .androidlogoImg.value!,
                                                fit: BoxFit.cover,
                                              ));
                                  } else {
                                    return Icon(
                                      Icons.image,
                                      size: height * 0.1,
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: dashboardCtrl.websiteCntrl,
                            decoration: InputDecoration(
                              labelText: "Website",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.05,
                              bottom: height * 0.01,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white),
                                  onPressed: () async {
                                    if (kIsWeb) {
                                      debugPrint(
                                          "web logo==${dashboardCtrl.selectedWebLogo.value.length}");
                                      dashboardCtrl.uplodForm(
                                          dashboardCtrl.companyEmailCntrl.text,
                                          dashboardCtrl.companyEmailCntrl.text,
                                          dashboardCtrl.websiteCntrl.text,
                                          dashboardCtrl
                                              .selectedWebLogo.value);
                                    } else {}
                                  },
                                  child: Text("Create"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
