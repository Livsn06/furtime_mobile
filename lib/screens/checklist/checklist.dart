import 'package:flutter/material.dart';
import 'package:furtime/controllers/checklist_screen_controller.dart';
import 'package:furtime/helpers/db_sqflite.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoScreenController>(
      init: TodoScreenController(),
      builder: (controller) {
        return Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: ALL_TODO_DATA.value.length,
                    itemBuilder: (context, index) {
                      final task = ALL_TODO_DATA.value[index];
                      return Dismissible(
                        key: Key(task.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          showConfirmModal(context,
                              label: 'Delete Task',
                              text:
                                  'Are you sure you want to delete this task?',
                              onConfirm: () async {
                            await DatabaseHelper.instance.deleteTodo(task.id!);
                            controller.allData();
                            Get.back();
                          });
                          return null;
                        },
                        child: InkWell(
                          onTap: () async {
                            var task = ALL_TODO_DATA.value[index];
                            task.isCompleted = !task.isCompleted!;
                            await DatabaseHelper.instance
                                .updateTodo(task.toJson());
                            ALL_TODO_DATA.refresh();
                          },
                          child: TodoItem(
                            title: task.title!,
                            description: task.description!,
                            time: task.time ?? '',
                            date: task.date ?? '',
                            isCompleted: task.isCompleted!,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class TodoItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String date;
  final bool isCompleted;

  const TodoItem({
    super.key,
    required this.title,
    this.description = '',
    this.time = '',
    this.date = '',
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: Checkbox(
            value: isCompleted,
            onChanged: (bool? value) {},
            activeColor: Colors.blue,
          ),
          title: Text(
            title,
            style: TextStyle(
              decoration: isCompleted ? TextDecoration.lineThrough : null,
              color: isCompleted ? Colors.grey : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: description.isNotEmpty || time.isNotEmpty || date.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (description.isNotEmpty)
                      Text(description, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        if (time.isNotEmpty)
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(time),
                            ],
                          ),
                        if (date.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(date),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}

class addTask extends StatefulWidget {
  const addTask({super.key});

  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool hasReminder = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
  }

  void _requestNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

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

  void _scheduleNotification(String title, String body, DateTime scheduleTime) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: scheduleTime.year,
        month: scheduleTime.month,
        day: scheduleTime.day,
        hour: scheduleTime.hour,
        minute: scheduleTime.minute,
        second: 0,
        millisecond: 0,
        timeZone: "Asia/Manila",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Create Task', style: TextStyle(color: Colors.black)),
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
              ElevatedButton(
                onPressed: () {
                  final newTask = {
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'date': DateFormat('yyyy-MM-dd').format(selectedDate),
                    'time': selectedTime.format(context),
                    'isCompleted': false,
                  };

                  if (hasReminder) {
                    final scheduleDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    _scheduleNotification(
                      titleController.text,
                      descriptionController.text,
                      scheduleDateTime,
                    );
                  }

                  Navigator.of(context).pop(newTask);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
