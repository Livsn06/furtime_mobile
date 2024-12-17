import 'package:flutter/material.dart';
import 'package:furtime/helpers/auth_api.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/auth/login_screen.dart';
import 'package:furtime/screens/auth/signup_screen.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/route_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _selectedIndex = 4;

  // List of widgets corresponding to each tab

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else if (index == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AllPets()));
      } else if (index == 2) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ToDoScreen()));
      } else if (index == 3) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CalendarScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[400],
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Profile | FurTime',
                  style: TextStyle(fontSize: 32.0),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.pageview_outlined),
              title: const Text('Trivia'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.perm_device_information_outlined),
              title: const Text('Terms and Conditions'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container with white background behind the profile picture
              Container(
                height: 200,
                width: 400,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 3.0,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 85.0,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/ttalgi.jpg",
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Name of the user
              const Text(
                'KIMI NO NAWA',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Secret@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              // Logout Button
              ElevatedButton(
                onPressed: () async {
                  // Logout the user
                  var result = await AuthApi.instance.logout();
                  if (result == true) {
                    Get.snackbar('Success', "You have successfully logout.");
                    Get.offAll(() => LoginScreen());
                  } else {
                    showFailedModal(
                      label: "Error",
                      text: result.toString(),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'LOG OUT',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              // Edit Profile Text
              GestureDetector(
                onTap: () {
                  // Add functionality to edit profile
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
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
  }
}
