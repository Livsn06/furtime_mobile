import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../helpers/db_sqflite.dart';
import '../helpers/post_api.dart';
import '../models/pet_model.dart';
import '../models/post_model.dart';
import '../models/task_model.dart';

class PetScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    allData();
  }

  void allData() async {
    var data = await DatabaseHelper.instance.queryAllRows();
    ALL_PET_DATA.value = PetModel.fromListJson(data);
    print(ALL_PET_DATA.value.length);
  }
}
