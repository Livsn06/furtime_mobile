import 'package:flutter/material.dart';
import 'package:furtime/controllers/comment_controller.dart';
import 'package:furtime/controllers/home_screen_controller.dart';
import 'package:furtime/helpers/post_api.dart';
import 'package:furtime/models/comment_model.dart';
import 'package:furtime/screens/post/UNUSED_commentScreen.dart';
import 'package:furtime/storage/auth_storage.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/widgets/build_form.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';

import '../helpers/image_parser.dart';

class PostCard extends StatefulWidget {
  final int userId;
  final String profileName;
  final String? profileImage;
  final String datetime;
  final String postText;
  final String postdesc;
  final String? imageUrl;
  final int postId;
  final int commentCount;

  const PostCard({
    super.key,
    required this.userId,
    required this.profileName,
    required this.profileImage,
    required this.datetime,
    required this.postText,
    required this.postdesc,
    required this.postId,
    required this.commentCount,
    this.imageUrl,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  var postsController = Get.put(HomeScreenController());
  var commentsController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage: widget.profileImage != null
                        ? NetworkImage(parseNetworkImage(widget.profileImage!))
                        : null,
                    child: widget.profileImage != null
                        ? null
                        : const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.profileName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        formatDateTime(widget.datetime),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BottomSheet(
                              backgroundColor: Colors.white,
                              onClosing: () {
                                print('onClosing');
                              },
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Visibility(
                                        visible: CURRENT_USER.value.uid ==
                                            widget.userId,
                                        child: ListTile(
                                          leading: const Icon(Icons.delete,
                                              color: Colors.red),
                                          title: const Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onTap: () {
                                            showConfirmModal(context,
                                                label: 'Delete Post',
                                                text:
                                                    'Post deleted successfully',
                                                onConfirm: () async {
                                              await PostApi.instance.deletePost(
                                                  postId: widget.postId);
                                              Get.snackbar('Success',
                                                  'Post deleted successfully');
                                              postsController.allData();
                                              Get.close(2);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.postText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                widget.postdesc,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              if (widget.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ImageNetwork(
                    image: parseNetworkImage(widget.imageUrl!),
                    height: 160,
                    width: double.infinity,
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommentPage(
                            postContent: 'This is the post Title',
                            postImage: 'assets/images/ttalgi.jpg', // Optional
                          ),
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () async {
                        ///

                        Get.defaultDialog(
                            backgroundColor: Colors.transparent,
                            barrierDismissible: false,
                            title: '',
                            content: const Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.grey,
                                  strokeWidth: 3,
                                ),
                              ],
                            ));
                        await commentsController.allData(widget.postId);
                        Get.close(1);
                        showComments();
                      },
                      child: const Icon(Icons.comment, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(widget.commentCount.toString(),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime =
        DateTime.parse(dateTimeString); // Replace with your DateTime
    String formattedDate = DateFormat("MMM d 'at' h:mm a").format(dateTime);
    return formattedDate;
  }

  void showComments() {
    var commentCtrl = TextEditingController();
    Get.bottomSheet(
      backgroundColor: const Color(0xFFE4E4E4),
      Container(
        height: SCREEN_SIZE.value.height,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                textFormInput(
                  controller: commentCtrl,
                  maxLine: 3,
                  hintColor: Colors.grey,
                  label: 'Write a comment',
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                      textColor: Colors.white,
                      color: Colors.deepOrange,
                      onPressed: () async {
                        //
                        var comment = CommentModel(
                          id: 0,
                          postId: widget.postId,
                          body: commentCtrl.text,
                          user: CURRENT_USER.value,
                          createdAt: DateTime.now().toString(),
                          updatedAt: DateTime.now().toString(),
                        );
                        var result = await PostApi.instance
                            .postComment(comment: comment);

                        if (result != null) {
                          return;
                        }

                        setState(() {
                          commentCtrl.clear();
                          postsController.allData();
                          commentsController.allData(comment.postId);
                        });
                      },
                      child: const Text('Post')),
                ),
                ...COMMENT_DATA.value.map((comment) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          backgroundImage: comment.user.photoUrl != null
                              ? NetworkImage(
                                  parseNetworkImage(comment.user.photoUrl!),
                                )
                              : null,
                          child: comment.user.photoUrl == null
                              ? const Icon(Icons.person, color: Colors.grey)
                              : null,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${comment.user.firstName} ${comment.user.lastName} ${comment.user.email == CURRENT_USER.value.email ? "(You)" : ''}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              formatDateTime(comment.createdAt.toString()),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            comment.body,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
