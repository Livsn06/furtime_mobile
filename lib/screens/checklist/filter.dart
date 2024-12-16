  import 'package:flutter/material.dart';
 

  class filterScreen extends StatefulWidget {
    final Function(bool?) applyFilter;
    filterScreen({required this.applyFilter});
    @override
    _filterScreenState createState() => _filterScreenState();
  }

  class _filterScreenState extends State<filterScreen> {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    bool? isCompleted;
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
      isCompleted = null;
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 213, 123, 4),
        title: Text('Filter List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF3F4F6),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            // Completion status section
            Text(
              'Task Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002347),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text('Completed'),
                    value: true,
                    groupValue: isCompleted,
                    onChanged: (value) {
                      setState(() {
                        isCompleted = value!;
                      });
                    },
                    activeColor:   Colors.amber,
                  ),
                  RadioListTile(
                    title: Text('Incomplete'),
                    value: false,
                    groupValue: isCompleted,
                    onChanged: (value) {
                      setState(() {
                        isCompleted = value!;
                      });
                    },
                    activeColor: Colors.amber,
                  ),
                  RadioListTile(
                    title: Text('Show All'),
                    value: null,
                    groupValue: isCompleted,
                    onChanged: (value) {
                      setState(() {
                        isCompleted = value!;
                      });
                    },
                    activeColor:   Colors.amber,
                  ),
                ],
              ),
            ),
           
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: ()  {
                 Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromARGB(255, 213, 123, 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Apply Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}