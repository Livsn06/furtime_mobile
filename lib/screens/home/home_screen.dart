import 'package:flutter/material.dart';
import 'package:furtime/data/PostCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Banner Section
        Container(
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
        ),
        const SizedBox(height: 16.0),
        // Post Cards
        PostCard(
          profileName: "Sam Guy",
          location: "Tempe, AZ",
          postText: "LIfe",
          postdesc: "Travel and you will born for a second time. ",
          imageUrl: "assets/images/ttalgi.jpg", // Replace with your image asset
        ),
        const SizedBox(height: 16.0),
        PostCard(
          profileName: "Sam Guy",
          location: "Tempe, AZ",
          postText: "Travel",
          postdesc: "Travel and you will born for a second time.",
          imageUrl: "assets/images/ttalgi.jpg", // Replace with your image asset
        ),
      ],
    );
  }
}
