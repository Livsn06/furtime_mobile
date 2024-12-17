import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../helpers/db_sqflite.dart';
import '../helpers/post_api.dart';
import '../models/pet_model.dart';
import '../models/post_model.dart';
import '../models/task_model.dart';

class TodoScreenController extends GetxController {
  RxList<TaskModel> todayList = RxList([]);
  RxList<TaskModel> tomorrowList = RxList([]);
  @override
  void onInit() {
    super.onInit();
    allData();
  }

  void allData() async {
    var data = await DatabaseHelper.instance.queryAllTodoRows();
    ALL_TODO_DATA.value = TaskModel.fromListJson(data);
    print("ALL TODO DATA: ${ALL_TODO_DATA.value.length}");

    todayList.value = getTodayList();
    tomorrowList.value = getTomorrowList();
  }

  List<TaskModel> getTodayList() {
    var today = ALL_TODO_DATA.value.map((todo) {
      if (DateTime.parse(todo.date!).day == DateTime.now().day &&
          DateTime.parse(todo.date!).month == DateTime.now().month &&
          DateTime.parse(todo.date!).year == DateTime.now().year) {
        return todo;
      }
      return TaskModel();
    }).toList();
    var finallist = today.where((element) => element.id != null).toList();
    return finallist.isEmpty ? [] : finallist;
  }

  List<TaskModel> getTomorrowList() {
    var today = ALL_TODO_DATA.value.map((todo) {
      if (DateTime.parse(todo.date!).day != DateTime.now().day &&
          DateTime.parse(todo.date!).month == DateTime.now().month &&
          DateTime.parse(todo.date!).year == DateTime.now().year) {
        return todo;
      }
      return TaskModel();
    }).toList();
    var finallist = today.where((element) => element.id != null).toList();
    return finallist.isEmpty ? [] : finallist;
  }
}
