import 'package:get/get.dart';

import '../controllers/ct_splash.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
    // Get.put<HomeController>(HomeController());
    // Get.put<CategoryController>(CategoryController());
    // Get.put<AboutController>(AboutController());
  }
}
