import 'package:get/get.dart';

import '../utils/_routes.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 3)).then((value) => goToHome());
  }

  void goToHome() {
    Get.offNamed(Routes.getLandingScreen);
  }
}
