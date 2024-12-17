import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

import '../data/reminderNotif.dart';

class CalendarController extends GetxController {
  @override
  onInit() {
    super.onInit();
    allData();
  }

  void allData() async {
    ALL_CALENDAR_DATA.value =
        ALL_TODO_DATA.value.map((task) => Reminder.fromJson(task)).toList();
  }
}
