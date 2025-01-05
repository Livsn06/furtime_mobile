import 'package:furtime/helpers/auth_api.dart';
import 'package:furtime/models/user_model.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../helpers/db_sqflite.dart';
import '../helpers/post_api.dart';
import '../models/pet_model.dart';
import '../models/post_model.dart';
import '../models/task_model.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    allData();
  }

  void allData() async {
    var data = await AuthApi.instance.session();
    if (data is UserModel) {
      CURRENT_USER.value = data;
    }
  }
}
