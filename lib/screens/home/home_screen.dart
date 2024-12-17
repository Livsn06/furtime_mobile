import 'package:flutter/material.dart';
import 'package:furtime/data/PostCard.dart';
import 'package:furtime/screens/post/createPost.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/profile/profile_screen.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

import '../../controllers/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ToDoScreen()));
      } else if (index == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AllPets()));
      } else if (index == 4) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
      } else if (index == 3) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CalendarScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              foregroundColor: Colors.white,
              backgroundColor: APP_THEME.value.colorScheme.secondary,
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
                  icon: const Icon(Icons.add),
                  iconSize: 35,
                )
              ],
            ),

            //
            body: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: ALL_POST_DATA.value.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/budol.jpg', // Replace with your image asset
                            height: 60,
                            width: 60,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'We care about your PET',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  //
                  var post = ALL_POST_DATA.value[index - 1];
                  print(post.image);
                  return PostCard(
                    profileName:
                        ("${post.user!.firstName} ${post.user!.lastName}"),
                    postText: post.title!,
                    postdesc: post.description!,
                    imageUrl: post.image,
                    datetime: post.createdAt!,
                  );
                },
              );
            }),

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
        });
  }
}





// assets/images/ttalgi.jpg