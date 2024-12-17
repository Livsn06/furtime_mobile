import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/start/onwalk_screen.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

import '../storage/auth_storage.dart';
import '../utils/_constant.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    delay();
    super.onReady();
  }

  verifySessions() async {
    var token = await AuthStorage.instance.verifyExistingToken();
    if (token == false) {
      Get.offAll(() => OnwalkScreen());
    }
    if (token is UserModel) {
      Get.snackbar('Success', 'You have successfully login.');
      CURRENT_USER.value = token;
      Get.offAll(() => const HomeScreen());
    }
  }

  void delay() async {
    await Future.delayed(const Duration(seconds: 5));
    await verifySessions();
  }
}
