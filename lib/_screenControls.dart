import 'package:flutter/material.dart';

import 'package:furtime/screens/allpets/AddPet.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/addScreen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/checklist/filter.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/post/createPost.dart';
import 'package:furtime/screens/profile/Profile.dart';
import 'package:furtime/utils/_constant.dart';
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
    const AllPetScreen(),
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
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrange,
      elevation: 0,
      title: const Text(
        'Dashboard',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const Createpost());
          },
          icon: const Icon(Icons.add_circle_outlined),
          iconSize: 35,
        )
      ],
    ),

    // All Pets
    AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrange,
      elevation: 0,
      title: const Text(
        'My Pets',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const AdditionalPet(),
                transition: Transition.fadeIn, preventDuplicates: true);
          },
          icon: const Icon(Icons.add_circle_outlined),
          iconSize: 35,
        )
      ],
    ),

    // Check List
    AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrange,
      elevation: 0,
      title: const Text(
        'Check List',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            Get.to(() => filterScreen(applyFilter: (bool? applyFilter) {}));
          },
          icon: const Icon(Icons.filter_list, color: Colors.white),
          label: const Text("Filter", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),

    // Calendar
    AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrange,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Calendar',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
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
    APP_THEME.value = Theme.of(context);
    return Scaffold(
      drawer: buildDrawer(),
      appBar: _appBars[_selectedIndex],
      body: _screens[_selectedIndex],

      //FLoating Action Button
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: () async {
                Get.to(() => const AddTask());
              },
              backgroundColor: Colors.deepOrange,
              child: const Icon(
                Icons.add_outlined,
                color: Colors.white,
              ),
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

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'FurTime',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Get.to(() => const ProfileScreen());
            },
          ),
        ],
      ),
    );
  }
}
