import 'package:flutter/material.dart';
import 'package:furtime/controllers/checklist_screen_controller.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

class filterScreen extends StatefulWidget {
  final Function(bool?) applyFilter;
  const filterScreen({super.key, required this.applyFilter});
  @override
  _filterScreenState createState() => _filterScreenState();
}

class _filterScreenState extends State<filterScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? isCompleted;

  bool isCompleteSelected = false;
  bool isNotCompleteSelected = false;
  bool isAllSelected = false;

  bool hasReminder = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime)
      setState(() {
        selectedTime = pickedTime;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    isCompleted = FILTERTYPE.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 213, 123, 4),
        title: const Text('Filter List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: TodoScreenController(),
          builder: (controller) {
            return Container(
              color: const Color(0xFFF3F4F6),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Completion status section
                  const Text(
                    'Task Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF002347),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber),
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          title: const Text('Completed'),
                          value: 'COMPLETED',
                          groupValue: isCompleted,
                          onChanged: (value) {
                            setState(() {
                              isCompleted = value!;
                              FILTERTYPE.value = value;
                            });
                          },
                          activeColor: Colors.amber,
                        ),
                        RadioListTile(
                          title: const Text('Incomplete'),
                          value: 'INCOMPLETE',
                          groupValue: isCompleted,
                          onChanged: (value) {
                            setState(() {
                              isCompleted = value!;
                              FILTERTYPE.value = value;
                            });
                          },
                          activeColor: Colors.amber,
                        ),
                        RadioListTile(
                          title: const Text('Show All'),
                          value: 'ALL',
                          groupValue: isCompleted,
                          onChanged: (value) {
                            setState(() {
                              isCompleted = value!;
                              FILTERTYPE.value = value;
                            });
                          },
                          activeColor: Colors.amber,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.allData();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 213, 123, 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Apply Filter',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
