import 'package:flutter/material.dart';
import 'package:furtime/screens/home/createPost.dart';
import 'package:furtime/screens/allpets/AddPet.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/addScreen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/checklist/filter.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:get/get.dart';

class ScreenControl extends StatefulWidget {
  const ScreenControl({super.key});

  @override
  State<ScreenControl> createState() => _ScreenControlState();
}

class _ScreenControlState extends State<ScreenControl> {
  int _selectedIndex = 0;
//
  // List of widgets corresponding to each tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const AllPetsScreen(),
    const ToDoScreen(),
    const CalendarScreen(),
  ];

//
  // List of bottom navigation bar items
  final List<BottomNavigationBarItem> _bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.pets),
      label: 'All Pets',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.check),
      label: 'Check List',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'Calendar',
    ),
  ];

//
  //List of AppBars
  final List<AppBar> _appBars = [
    //Home
    AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CreatePost());
            },
            icon: const Icon(Icons.add_to_photos_outlined),
            iconSize: 35,
          )
        ]),

    // All Pets
    AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'My Pets',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AdditionalPet());
            },
            icon: const Icon(Icons.add_to_photos_outlined),
            iconSize: 35,
          )
        ]),

    // Check List
    AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'Check List',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Get.to(() => FilterScreen(applyFilter: (bool? applyFilter) {}));
            },
            icon: const Icon(Icons.filter_list, color: Colors.black),
            label: const Text("Filter", style: TextStyle(color: Colors.black)),
          ),
        ]),

    // Calendar
    AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.amber,
      elevation: 0,
      title: const Text(
        'Calendar',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
  ];

// Function to handle navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_selectedIndex],
      body: _screens[_selectedIndex],

      //FLoating Action Button
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => const AddTask());
              },
              backgroundColor: Colors.grey,
              child: const Icon(Icons.add_outlined),
            )
          : null,
      //
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        fixedColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _bottomNavItems,
      ),
    );
  }
}
