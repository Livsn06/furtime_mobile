import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furtime/controllers/calendar_controller.dart';
import 'package:furtime/controllers/checklist_screen_controller.dart';
import 'package:furtime/models/reminderNotif.dart';
import 'package:furtime/models/task_model.dart';
import 'package:furtime/widgets/build_form.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../helpers/db_sqflite.dart';

class EditTask extends StatefulWidget {
  EditTask({super.key, required this.task});
  TaskModel task;
  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<EditTask> {
  @override
  void initState() {
    // TODO: implement initState

    var formatTime = DateFormat('HH:mm').parse(widget.task.time!);
    var time = DateTime.parse(formatTime.toString());

    //
    titleController.text = widget.task.title!;
    descriptionController.text = widget.task.description!;
    selectedDate = DateTime.parse(widget.task.date!);

    selectedTime = TimeOfDay.fromDateTime(time);
    super.initState();
  }

  var taskController = Get.put(TodoScreenController());
  var reminderController = Get.put(CalendarController());
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool hasReminder = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TodoScreenController());
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                    "Select Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text("Select Time: ${selectedTime.format(context)}"),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),
              // SwitchListTile(
              //   title: const Text('Set Reminder'),
              //   value: hasReminder,
              //   onChanged: (value) {
              //     setState(() {
              //       hasReminder = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 20),
              customButton(
                label: "Update Task",
                color: Colors.deepOrange,
                onPress: () async {
                  showConfirmModal(context,
                      label: "Update Task",
                      text: "Are you sure you want to update this task?",
                      onConfirm: () async {
                    showLoadingModal(
                        label: "Update Task", text: "Please wait...");

                    var task = TaskModel(
                      id: widget.task.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateFormat('yyyy-MM-dd').format(selectedDate),
                      time: selectedTime.format(context),
                      isCompleted: false,
                      reminder: true,
                      notificationID: widget.task.notificationID,
                    );

                    int isSuccess =
                        await DatabaseHelper.instance.updateTodo(task.toJson());
                    Get.close(1);

                    if (isSuccess > 0) {
                      showSuccessModal(
                        label: "Success",
                        text: "Task updated successfully",
                      );
                      AwesomeNotifications().cancel(widget.task.notificationID);

                      AwesomeNotifications().createNotification(
                        content: NotificationContent(
                          id: widget.task.notificationID,
                          channelKey: 'basic_channel',
                          title: 'Task Reminder',
                          body: '${task.description}',
                          notificationLayout: NotificationLayout.Default,
                        ),
                        schedule: NotificationCalendar(
                          year: selectedDate.year,
                          month: selectedDate.month,
                          day: selectedDate.day,
                          hour: selectedTime.hour,
                          minute: selectedTime.minute,
                          second: 0,
                          millisecond: 0,
                          timeZone: "Asia/Manila",
                        ),
                      );
                      Get.close(3);
                      controller.allData();
                      reminderController.allData();
                    } else {
                      showFailedModal(
                        label: "Error",
                        text: "Failed to add task",
                      );
                    }
                    taskController.allData();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
