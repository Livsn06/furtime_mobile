import 'package:furtime/controllers/checklist_screen_controller.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

import '../models/reminderNotif.dart';

class CalendarController extends GetxController {
  @override
  onInit() {
    super.onInit();
    allData();
  }

  void allData() async {
    var todocontroller = Get.put(TodoScreenController());
    ALL_CALENDAR_DATA.value =
        ALL_TODO_DATA.value.map((task) => Reminder.fromJson(task)).toList();
  }
}
