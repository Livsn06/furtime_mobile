import 'package:flutter/material.dart';
import 'package:furtime/models/task_model.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/addScreen.dart';
import 'package:furtime/screens/checklist/filter.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/profile/profile_screen.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../controllers/checklist_screen_controller.dart';
import '../../helpers/db_sqflite.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else if (index == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AllPets()));
      } else if (index == 4) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
      } else if (index == 3) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CalendarScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    //
    return GetBuilder<TodoScreenController>(
        init: TodoScreenController(),
        builder: (controller) {
          return Obx(() {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                foregroundColor: Colors.white,
                backgroundColor: APP_THEME.value.colorScheme.secondary,
                elevation: 0,
                title: const Text(
                  'Check List',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => filterScreen(
                                applyFilter: (bool? applyFilter) {},
                              )));
                    },
                    icon: const Icon(Icons.filter_list),
                    label: const Text("Filter"),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          if (controller.todayList.isEmpty)
                            const Text(
                              '- No Today tasks found -',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ...controller.todayList.map((todo) {
                            print("isCompleted: ${todo.isCompleted}");

                            //date only

                            return TodoItem(
                              title: todo.title!,
                              description: todo.description!,
                              time: todo.time!,
                              date: todo.date!,
                              isCompleted: todo.isCompleted!,
                              onChanged: (value) async {
                                var newTodo = TaskModel(
                                  id: todo.id,
                                  title: todo.title,
                                  description: todo.description,
                                  date: todo.date,
                                  time: todo.time,
                                  isCompleted: value ?? false,
                                  reminder: todo.reminder,
                                );

                                await DatabaseHelper.instance
                                    .updateTodo(newTodo.toJson());
                                controller.allData();
                              },
                            );
                          }),
                          const Gap(20),
                          Divider(
                            color: Colors.grey[300],
                          ),
                          const Gap(20),
                          const Text(
                            'Tomorrow',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          if (controller.tomorrowList.isEmpty)
                            const Text(
                              '- No Upcoming tasks found -',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),

                          //
                          ...controller.tomorrowList.map((todo) {
                            return TodoItem(
                              title: todo.title!,
                              description: todo.description!,
                              time: todo.time!,
                              date: todo.date!,
                              isCompleted: todo.isCompleted!,
                              onChanged: (value) async {
                                var newTodo = TaskModel(
                                  id: todo.id,
                                  title: todo.title,
                                  description: todo.description,
                                  date: todo.date,
                                  time: todo.time,
                                  isCompleted: value ?? false,
                                  reminder: todo.reminder,
                                );

                                await DatabaseHelper.instance
                                    .updateTodo(newTodo.toJson());
                                controller.allData();
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(() => const addTask());
                      },
                      foregroundColor: Colors.white,
                      backgroundColor: APP_THEME.value.colorScheme.secondary,
                      child: const Icon(Icons.add_outlined),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                useLegacyColorScheme: false,
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                fixedColor: Colors.blue,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pets),
                    label: 'All Pets',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check),
                    label: 'Check List',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: 'Calendar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          });
        });
  }
}

class TodoItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String date;
  final bool isCompleted;

  final Function(bool?)? onChanged;

  const TodoItem({
    super.key,
    required this.title,
    this.description = '',
    this.time = '',
    this.date = '',
    required this.isCompleted,
    this.onChanged,
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
            onChanged: (value) async {
              await onChanged!(value);
            },
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
          subtitle:
              (description.isNotEmpty || time.isNotEmpty || date.isNotEmpty) &&
                      !isCompleted
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



//                  TodoItem(
//                     title: "Return library books",
//                     description: "Gather overdue library books and return...",
//                     time: "11:30 AM",
//                     date: "26/11/24",
//                     isCompleted: false,
//                   ),