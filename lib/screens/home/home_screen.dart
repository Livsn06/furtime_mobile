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
  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (context) {
        return Obx(() {
          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
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

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: PostCard(
                  userId: post.user?.uid ?? 0,
                  postId: post.id!,
                  profileImage: post.user?.photoUrl,
                  profileName:
                      ("${post.user!.firstName} ${post.user!.lastName} ${post.user?.email == CURRENT_USER.value.email ? "(You)" : ''}"),
                  postText: post.title!,
                  postdesc: post.description!,
                  imageUrl: post.image,
                  datetime: post.createdAt!,
                  commentCount: post.comments,
                ),
              );
            },
          );
        });
      },
    );
  }
}
