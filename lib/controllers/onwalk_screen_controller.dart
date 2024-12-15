import 'package:furtime/models/onwalk_model.dart';
import 'package:get/get.dart';

import '../utils/_utils.dart';

class OnwalkScreenController extends GetxController with OnwalkData {
  //

  ///
  List<OnwalkModel> get getData => _onwalkData;

  //
}

mixin OnwalkData {
  final _onwalkData = [
    OnwalkModel(
      title: "Welcome!",
      description:
          "FurTime offer you a care and love that is tailored to what your pets deserve.",
      image: InitAssets.path.getStartIcon1,
    ),
    OnwalkModel(
      title: "Discover",
      description: "your pets health status and health conditions.",
      image: InitAssets.path.getStartIcon2,
    ),
    OnwalkModel(
      title: "Find",
      description: "your best fur and make an appointment.",
      image: InitAssets.path.getStartIcon3,
    ),
  ];
}
