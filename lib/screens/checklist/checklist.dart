import 'package:flutter/material.dart';
import 'package:furtime/controllers/checklist_screen_controller.dart';
import 'package:furtime/helpers/db_sqflite.dart';
import 'package:furtime/models/task_model.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';

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
          List<TaskModel>? data;
          if (FILTERTYPE.value == 'ALL') {
            data = ALL_TODO_DATA.value;
          } else if (FILTERTYPE.value == 'TODAY') {
            data = controller.getCompleted();
          } else if (FILTERTYPE.value == 'TOMORROW') {
            data = controller.getIncompleted();
          }
          if (data == null || data.isEmpty) {
            return const Center(
              child: Text('- No tasks found -',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic)),
            );
          }

          //
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final task = data![index];
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
                            var task = data![index];
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
