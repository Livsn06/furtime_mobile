import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furtime/controllers/checklist_screen_controller.dart';
import 'package:furtime/models/task_model.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/profile/profile_screen.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/widgets/build_form.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../helpers/db_sqflite.dart';

class addTask extends StatefulWidget {
  const addTask({super.key});

  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
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
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: APP_THEME.value.colorScheme.secondary,
        centerTitle: true,
        elevation: 0,
        title: const Text('Create Task'),
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
              SwitchListTile(
                title: const Text('Set Reminder'),
                value: hasReminder,
                onChanged: (value) {
                  setState(() {
                    hasReminder = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              customButton(
                label: "Add Task",
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
                      reminder: hasReminder,
                    );

                    int isSuccess =
                        await DatabaseHelper.instance.insertTodo(task.toJson());
                    Get.close(1);

                    if (isSuccess > 0) {
                      showSuccessModal(
                        label: "Success",
                        text: "Task added successfully",
                      );
                      Get.close(3);
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
