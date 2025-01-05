import 'package:flutter/material.dart';
import 'package:furtime/controllers/profileController.dart';
import 'package:furtime/helpers/auth_api.dart';
import 'package:furtime/helpers/image_parser.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/auth/login_screen.dart';
import 'package:furtime/screens/auth/signup_screen.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/profile/editScreen.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepOrange,
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Obx(() {
                  return Column(
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
                                          parseNetworkImage(
                                              CURRENT_USER.value.photoUrl!),
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/ttalgi.jpg",
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Name of the user
                      Text(
                        '${CURRENT_USER.value.firstName} ${CURRENT_USER.value.lastName}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${CURRENT_USER.value.email}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      // Logout Button
                      ElevatedButton(
                        onPressed: () async {
                          // Logout the user
                          showLoadingModal(
                              label: "Logout", text: "Please wait...");
                          var result = await AuthApi.instance.logout();
                          Get.close(1);
                          if (result == true) {
                            Get.snackbar(
                                'Success', "You have successfully logout.");
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
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
                          Get.to(() => const EditProfileScreen());
                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
        });
  }
}
