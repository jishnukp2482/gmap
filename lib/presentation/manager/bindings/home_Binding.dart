import 'package:get/get.dart';
import 'package:gmap/presentation/manager/controller/home_Controller.dart';

import '../../../injector.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(sl(),sl()),
    );
  }
}
