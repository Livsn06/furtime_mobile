import 'package:furtime/helpers/db_sqflite.dart';

class TaskModel {
  //  DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedTime = TimeOfDay.now();
  // bool hasReminder = false;

  // final TextEditingController titleController = TextEditingController();
  // final TextEditingController descriptionController = TextEditingController();

  int? id;
  String? title;
  String? description;
  String? date;
  String? time;
  bool? isCompleted;
  bool? reminder;
  int user_ID = 1;
  int notificationID = 0;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.isCompleted,
    this.reminder,
    this.user_ID = 0,
    this.notificationID = 0,
  });

  static List<TaskModel> fromListJson(List<Map<String, dynamic>> json) {
    if (json.isEmpty) {
      return [];
    }

    return json.map((e) => TaskModel.fromJson(e)).toList();
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    var dbHelper = DatabaseHelper();
    return TaskModel(
      id: json[dbHelper.todoId],
      title: json[dbHelper.todoTitle],
      description: json[dbHelper.todoDescription],
      date: json[dbHelper.todoDate],
      time: json[dbHelper.todoTime],
      isCompleted: json[dbHelper.todoIsCompleted] == 1 ? true : false,
      reminder: json[dbHelper.hasReminder] == 1 ? true : false,
      user_ID: json[dbHelper.todo_user_ID],
      notificationID: json[dbHelper.notification_ID],
    );
  }

  Map<String, dynamic> toJson() {
    var dbHelper = DatabaseHelper();
    return {
      dbHelper.todoId: id,
      dbHelper.todoTitle: title,
      dbHelper.todoDescription: description,
      dbHelper.todoDate: date,
      dbHelper.todoTime: time,
      dbHelper.todoIsCompleted: isCompleted == true ? 1 : 0,
      dbHelper.hasReminder: reminder == true ? 1 : 0,
      dbHelper.todo_user_ID: user_ID,
      dbHelper.notification_ID: notificationID
    };
  }
}
