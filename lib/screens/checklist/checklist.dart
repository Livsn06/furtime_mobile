import 'package:flutter/material.dart';
import 'package:furtime/screens/checklist/addScreen.dart';
import 'package:furtime/screens/checklist/filter.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: const [
                Text(
                  'Today',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TodoItem(
                  title: "Return library books",
                  description: "Gather overdue library books and return...",
                  time: "11:30 AM",
                  date: "26/11/24",
                  isCompleted: false,
                ),
                TodoItem(
                  title: "Go for grocery shop",
                  description: "",
                  isCompleted: true,
                ),
                TodoItem(
                  title: "Donate unwanted items",
                  description: "",
                  isCompleted: true,
                ),
                Text(
                  'Tomorrow',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
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
