import 'package:flutter/material.dart';
import 'package:furtime/screens/commentScreen.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';

import '../helpers/image_parser.dart';

class PostCard extends StatelessWidget {
  final String profileName;
  final String datetime;
  final String postText;
  final String postdesc;
  final String? imageUrl;

  const PostCard({
    super.key,
    required this.profileName,
    required this.datetime,
    required this.postText,
    required this.postdesc,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        formatDateTime(datetime),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                postText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                postdesc,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ImageNetwork(
                    image: parseNetworkImage(imageUrl!),
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
                    child: const Icon(Icons.comment, color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  const Text('3', style: TextStyle(color: Colors.grey)),
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
}
