import 'package:flutter/material.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/addScreen.dart';
import 'package:furtime/screens/checklist/filter.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/profile/profile_screen.dart';
import 'package:intl/intl.dart';

class ToDoScreen extends StatefulWidget {
  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  int _selectedIndex = 2;

  List<Map<String, dynamic>> tasks = [
    {
      'title': "Return library books",
      'description': "Gather overdue library books and return...",
      'time': "11:30 AM",
      'date': "26/11/24",
      'isCompleted': false,
    },
    {
      'title': "Go for grocery shop",
      'description': "",
      'isCompleted': true,
    },
    {
      'title': "Donate unwanted items",
      'description': "",
      'isCompleted': true,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (index == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AllPets()));
      } else if (index == 4) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      } else if (index == 3) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[400],
        elevation: 0,
        title: const Text(
          'Check List',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => filterScreen(applyFilter: (bool? applyFilter) {})));
            },
            icon: const Icon(Icons.filter_list, color: Colors.black),
            label: const Text("Filter", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TodoItem(
                    title: task['title'],
                    description: task['description'],
                    time: task['time'] ?? '',
                    date: task['date'] ?? '',
                    isCompleted: task['isCompleted'],
                  );
                },
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
              onPressed: () async {
                final newTask = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => addTask()),
                );

                if (newTask != null) {
                  setState(() {
                    tasks.add(newTask);
                  });
                }
              },
              backgroundColor: Colors.grey,
              child: const Icon(Icons.add_outlined),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        unselectedLabelStyle: TextStyle(color: Colors.black),
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
  }
}

class TodoItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String date;
  final bool isCompleted;

  const TodoItem({
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
  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Create Task', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text("Select Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text("Select Time: ${selectedTime.format(context)}"),
                trailing: Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),
              SwitchListTile(
                title: Text('Set Reminder'),
                value: hasReminder,
                onChanged: (value) {
                  setState(() {
                    hasReminder = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newTask = {
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'date': DateFormat('yyyy-MM-dd').format(selectedDate),
                    'time': selectedTime.format(context),
                    'isCompleted': false,
                  };

                  Navigator.of(context).pop(newTask);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
