import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

import '../helpers/post_api.dart';
import '../models/post_model.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    allData();
  }

  void allData() async {
    ALL_POST_DATA.value = await PostApi.instance.getAllPosts();
  }
}
