import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/routes/app_pages.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // builder: (context, child) {
      //   ErrorWidget.builder = (details) {
      //     return ErrorWidgetClass(details, () {});
      //   };
      //   return child!;
      // },
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.formPage,
      getPages: AppRoutes.routes,
    );
  }
}
