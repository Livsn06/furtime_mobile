import 'package:furtime/models/task_model.dart';

/// Reminder class
class Reminder {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final TaskModel taskModel;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.taskModel,
  });

  factory Reminder.fromJson(TaskModel json) {
    return Reminder(
      id: json.id!,
      title: json.title!,
      description: "${json.description!} at ${json.time!}",
      dateTime: DateTime.parse(json.date!),
      taskModel: json,
    );
  }
}
