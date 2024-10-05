import 'package:flutter/material.dart';
import 'package:furtime/utils/_screen_size.dart';
import 'package:get/get.dart';

import '../../controllers/ct_splash.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  double screen = 0;
  @override
  Widget build(BuildContext context) {
    var ctSplash = Get.find<SplashScreenController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        var screen = Screen.constraints(constraints);

        //
        return Scaffold(
          body: Center(
            child: Text(
              'Splash Screen',
              style: TextStyle(fontSize: screen.width / 30),
            ),
          ),
        );
      },
    );
  }
}
