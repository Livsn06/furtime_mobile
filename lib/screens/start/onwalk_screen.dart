import 'package:flutter/material.dart';
import 'package:furtime/controllers/onwalk_screen_controller.dart';
import 'package:furtime/screens/auth/login_screen.dart';
import 'package:get/get.dart';

import '../../controllers/splash_screen_controller.dart';
import '../../utils/_constant.dart';
import '../../utils/_utils.dart';

class OnwalkScreen extends StatelessWidget {
  OnwalkScreen({super.key});

  var pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    //
    return GetBuilder<OnwalkScreenController>(
      init: OnwalkScreenController(),

      //
      builder: (controller) {
        return Scaffold(
          body: Container(
            width: SCREEN_SIZE.value.width,
            height: SCREEN_SIZE.value.height,
            decoration: screenDecoration(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: SCREEN_SIZE.value.height / 15),
              child: PageView.builder(
                itemCount: controller.getData.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => LoginScreen());
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      space(height: 20),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.getData[index].title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          space(height: 10),
                          Text(
                            controller.getData[index].description,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      space(height: 20),
                      //? SPLASH ICON
                      Image.asset(
                        controller.getData[index].image,
                        fit: BoxFit.cover,
                      ),
                      space(height: 20),
                      //? APP TITLE
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Decoration screenDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(InitAssets.path.splashBackground),
        fit: BoxFit.cover,
      ),
    );
  }
}



  //  return Scaffold(
  //         body: Container(
  //           width: SCREEN_SIZE.value.width,
  //           height: SCREEN_SIZE.value.height,
  //           decoration: screenDecoration(),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,

  //             //
  //             children: [
  //               //? SPLASH ICON
  //               Image.asset(
  //                 InitAssets.path.getStartIcon1,
  //                 width: SCREEN_SIZE.value.width / 2.5,
  //                 height: SCREEN_SIZE.value.width / 2.5,
  //               ),
  //               space(height: 20),

  //               //? APP TITLE
  //               Text(
  //                 APP_TITLE.value,
  //                 style: const TextStyle(
  //                   fontSize: 24,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );