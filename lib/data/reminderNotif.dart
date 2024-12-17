import 'package:furtime/models/task_model.dart';

/// Reminder class
class Reminder {
  final String title;
  final String description;
  final DateTime dateTime;

  Reminder({
    required this.title,
    required this.description,
    required this.dateTime,
  });

  factory Reminder.fromJson(TaskModel json) {
    return Reminder(
      title: json.title!,
      description: "${json.description!} at ${json.time!}",
      dateTime: DateTime.parse(json.date!),
    );
  }
}

/// Prelisted reminders
final List<Reminder> prelistedReminders = [
  Reminder(
    title: "Meeting with WHO KNOWS WHO",
    description: "Discuss project updates at 10:00 PM",
    dateTime: DateTime(2024, 12, 6),
  ),
  Reminder(
    title: "Doctor's Appointment",
    description: "Visit Dr. Smith at 10:00 AM",
    dateTime: DateTime(2024, 12, 10),
  ),
  Reminder(
    title: "Meeting with John",
    description: "Discuss project updates at 2:00 PM",
    dateTime: DateTime(2024, 12, 15),
  ),
];
