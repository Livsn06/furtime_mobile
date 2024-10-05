import 'package:get/get.dart';

import '../screens/auth/login.dart';
import '../screens/auth/signup.dart';
import '../screens/home/home.dart';
import '../screens/intro/landing.dart';
import '../screens/intro/splash.dart';

class Routes {
  static get getLandingScreen => '/landing';
  static get getLoginScreen => '/login';
  static get getSignupScreen => '/signup';
  static get getHomeScreen => '/home';
  static get getSplashScreen => '/';

  static List<GetPage> screens = [
    GetPage(
      name: getSplashScreen,
      page: () => SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: getLandingScreen,
      page: () => LandingScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: getSignupScreen,
      page: () => SignupScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: getLoginScreen,
      page: () => LoginScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: getHomeScreen,
      page: () => HomeScreen(),
      transition: Transition.fade,
    ),
  ];
}
