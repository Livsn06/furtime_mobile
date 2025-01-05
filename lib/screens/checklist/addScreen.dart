import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furtime/controllers/checklist_screen_controller.dart';
import 'package:furtime/models/task_model.dart';
import 'package:furtime/widgets/build_form.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../helpers/db_sqflite.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<AddTask> {
  var taskController = Get.put(TodoScreenController());
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
          'Create Task',
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
                label: "Add Task",
                color: Colors.deepOrange,
                onPress: () async {
                  showConfirmModal(context,
                      label: "Add Task",
                      text: "Are you sure you want to add this task?",
                      onConfirm: () async {
                    showLoadingModal(label: "Add Task", text: "Please wait...");

                    var task = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateFormat('yyyy-MM-dd').format(selectedDate),
                      time: selectedTime.format(context),
                      isCompleted: false,
                      reminder: true,
                    );

                    int isSuccess =
                        await DatabaseHelper.instance.insertTodo(task.toJson());

                    Get.close(1);

                    if (isSuccess > 0) {
                      showSuccessModal(
                        label: "Success",
                        text: "Task added successfully",
                      );
                      AwesomeNotifications().createNotification(
                        content: NotificationContent(
                          id: 1,
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
                      //
                      Get.close(3);
                      controller.allData();
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
