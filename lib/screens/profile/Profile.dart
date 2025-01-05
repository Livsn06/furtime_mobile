import 'package:flutter/material.dart';
import 'package:furtime/drawer/doanddont.dart';
import 'package:furtime/drawer/faqScreen.dart';
import 'package:furtime/drawer/tips.dart';
import 'package:furtime/screens/auth/login_screen.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';

import '../../helpers/auth_api.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        title: const Text('Profile'),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'FurTime',
                  style: TextStyle(fontSize: 32.0),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Tips & Care'),
              onTap: () {
                // Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TipsScreen(
                        petType: 'dog'), // Pass the dog type dynamically
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.perm_device_information_outlined),
              title: const Text('FAQS'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FAQScreen(
                        petType: 'dog'), // Replace 'dog' with a dynamic value
                  ),
                );
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
                          child: CURRENT_USER.value.photoUrl != null
                              ? Image.network(
                                  CURRENT_USER.value.photoUrl!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.white,
                                ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Name of the user
              Text(
                '${CURRENT_USER.value.firstName} ${CURRENT_USER.value.lastName}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${CURRENT_USER.value.email}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              // Logout Button
              ElevatedButton(
                onPressed: () async {
                  // Logout the user
                  showLoadingModal(label: "Logout", text: "Please wait...");
                  var result = await AuthApi.instance.logout();
                  Get.close(1);
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
    );
  }
}
