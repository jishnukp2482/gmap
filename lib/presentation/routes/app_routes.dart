import 'package:get/get.dart';
import 'package:gmap/presentation/manager/bindings/home_Binding.dart';
import 'package:gmap/presentation/pages/formPage.dart';
import 'package:gmap/presentation/pages/homePage.dart';
import 'package:gmap/presentation/pages/map_page.dart';
import 'package:gmap/presentation/routes/app_pages.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: AppPages.homePage, page: ()=>HomePage(),binding: HomeBinding()),
    GetPage(name: AppPages.formPage, page: ()=>CreateNewCompany(),binding: HomeBinding()),
    
  ];
}
