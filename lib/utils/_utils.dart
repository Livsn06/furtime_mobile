import 'package:flutter/material.dart';

class InitAssets {
  static final path = InitAssets();

//
  var splashIcon = 'assets/images/splash_icon.png';
  var splashBackground = 'assets/images/splash_bg.jpg';
  var getStartIcon1 = 'assets/images/get_start_icon.png';
  var getStartIcon2 = 'assets/images/get_start_icon2.png';
  var getStartIcon3 = 'assets/images/get_start_icon3.png';
  var loginImage = 'assets/images/login_image.png';
  var signupImage = 'assets/images/register_image.jpg';
}

///--------------------------
///

//FOR SPACING
SizedBox space({double height = 0, double width = 0}) {
  return SizedBox(
    height: height,
    width: width,
  );
}
