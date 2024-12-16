import 'package:flutter/material.dart';
import 'package:furtime/screens/commentScreen.dart';

class PostCard extends StatelessWidget {
  final String profileName;
  final String location;
  final String postText;
  final String postdesc;
  final String imageUrl;

  PostCard({
    required this.profileName,
    required this.location,
    required this.postText,
    required this.postdesc,
    required this.imageUrl,
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
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                postText,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), 
              ),    SizedBox(height: 12),
               Text(
                postdesc,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrl, // Replace with your image asset
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 12),
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
                            postImage: 'assets/images/budol.jpg', // Optional
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.comment, color: Colors.grey),
                  ),
                  SizedBox(width: 4),
                  Text('3', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
