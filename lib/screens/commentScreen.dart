import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  final String postContent; // Pass the post content from the previous screen
  final String postImage; // Pass the post image URL (optional)

  const CommentPage({super.key, required this.postContent, required this.postImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.amber[400],
        elevation: 0,
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the tapped post's content
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.brown[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(postContent,
                    style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                  ), SizedBox(height: 5.0),
                  if (postImage != null)
                    Image.asset(postImage, height: 150, width: 400,), // Display the post image if available
                  SizedBox(height: 16.0),
                  
                ],
              ),
            ),
        SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    //controller: _commentController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type your comment here...',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the comment page after submission
                  },
                  child: Text('Post'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ],
            ),
            // Placeholder for other comments
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24.0,
                      backgroundImage: AssetImage('assets/images/budol.jpg'), // Replace with a placeholder image
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('This is a sample comment. You can customize the layout and styling as needed.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}