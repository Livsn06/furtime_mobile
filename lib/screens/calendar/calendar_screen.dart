import 'package:flutter/material.dart';
import 'package:furtime/controllers/checklist_screen_controller.dart';
import 'package:furtime/models/reminderNotif.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/checklist/editScreen.dart';

import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controllers/calendar_controller.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Use the predefined reminders
  DateTime _selectedDay = DateTime.now(); // Keep track of the selected day
  var todoController = Get.put(TodoScreenController());
  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    ///
    return GetBuilder(
        init: CalendarController(),
        builder: (controller) {
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(1990, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _selectedDay,
                calendarFormat: CalendarFormat.month,
                eventLoader: (day) => _getEventsForDay(day),
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });

                  final remindersForDate = _getEventsForDay(selectedDay);

                  if (remindersForDate.isNotEmpty) {
                    for (var reminder in remindersForDate) {
                      _showReminderDialog(reminder);
                    }
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.info,
                      title: 'No Reminders',
                      text: 'No reminders found for this date.',
                      confirmBtnText: 'OKAY',
                    );
                  }
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false, // Hides the format button
                  titleCentered: true, // Centers the title
                  leftChevronVisible: true, // Shows the left chevron
                  rightChevronVisible: true, // Shows the right chevron
                  titleTextStyle: TextStyle(
                    fontSize: 20, // Font size of the title
                    fontWeight: FontWeight.bold, // Font weigh
                  ),
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //   color: Colors.black.withOpacity(0.8), // Color of the border
                  //   width: 1, // Width of the border
                  // ),
                  // color: Colors.white,
                  // )
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _buildRemindersList(),
              ),
            ],
          );
        });
  }

  /// Fetches reminders for a specific day
  List<Reminder> _getEventsForDay(DateTime day) {
    return ALL_CALENDAR_DATA.value
        .where((reminder) => isSameDay(day, reminder.dateTime))
        .toList();
  }

  /// Builds the reminders list below the calendar
  Widget _buildRemindersList() {
    final remindersForDate = _getEventsForDay(_selectedDay);

    if (remindersForDate.isEmpty) {
      return Center(
        child: Text(
          'No reminders for this date.',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }

    return ListView.builder(
      itemCount: remindersForDate.length,
      itemBuilder: (context, index) {
        final reminder = remindersForDate[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(
              reminder.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(reminder.description),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                _editReminder(reminder);
              },
            ),
            onTap: () {
              _showReminderDialog(reminder);
            },
          ),
        );
      },
    );
  }

  /// Shows a QuickAlert dialog for the selected reminder
  void _showReminderDialog(Reminder reminder) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: reminder.title,
      text: reminder.description,
      confirmBtnText: 'OKAY',
    );
  }

  /// Handles editing a reminder
  void _editReminder(Reminder reminder) {
    // Navigate to the edit reminder screen (to be implemented)
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: 'Edit Reminder',
        text: 'Are you sure you want to edit this reminder?',
        confirmBtnText: 'Confirm',
        cancelBtnText: 'Cancel',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => EditTask(task: reminder.taskModel)));
        },
        onCancelBtnTap: () {
          Navigator.pop(context);
        });
  }
}

/// Helper function to compare only the date part of DateTime objects
bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
