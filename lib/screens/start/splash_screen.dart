import 'package:flutter/material.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/utils/_utils.dart';
import 'package:get/get.dart';

import '../../controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    //
    //
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),

      //
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.deepOrange,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              //
              children: [
                //? SPLASH ICON
                Image.asset(
                  InitAssets.path.splashIcon,
                  width: SCREEN_SIZE.value.width / 2.5,
                  height: SCREEN_SIZE.value.width / 2.5,
                ),
                space(height: SCREEN_SIZE.value.width / 40),

                //? APP TITLE
                Text(
                  APP_TITLE.value,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
