import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/profile/profile_screen.dart';
import 'package:intl/intl.dart';

class addTask extends StatefulWidget {
 
  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {

  int _selectedIndex = 0;

  // List of widgets corresponding to each tab
  final List<Widget> _screens = [
    const Center(child: Text('Home Screen')), // Home tab content
    const Center(child: Text('Search Screen')), // Search tab content
    const Center(child: Text('Profile Screen')), // Profile tab content
  ];

  void _onItemTapped(int index) {
    setState(() {
      if(index == 2){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
      }
      else if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllPets()));
      }
      if(index == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
    });
  }


  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool hasReminder = false;


  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

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
                onPressed: ()  {
                 Navigator.of(context).pop(
                  MaterialPageRoute(builder: (_) => ToDoScreen()));
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
