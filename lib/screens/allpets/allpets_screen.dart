import 'package:flutter/material.dart';
import 'package:furtime/data/PetCard.dart';
import 'package:furtime/screens/allpets/AddPet.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/profile/profile_screen.dart';

class AllPetsScreen extends StatefulWidget {
  const AllPetsScreen({super.key});

  @override
  State<AllPetsScreen> createState() => _AllPetsScreenState();
}

class _AllPetsScreenState extends State<AllPetsScreen> {
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
                'assets/images/ttalgi.jpg', // Replace with your image asset
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
        // Pet Cards
        PetCard(
          imageUrl: "assets/images/ash.jpg", // Replace with your image asset
          petName: "Ash",
          age: "2" " Yrs old",
          breed: "Persian",
          gender: 'Female',
        ),
        const SizedBox(height: 16.0),
        PetCard(
          imageUrl: "assets/images/ashh.jpg", // Replace with your image asset
          petName: "Ash",
          age: "2" " Yrs old",
          breed: "Persian",
          gender: 'Female',
        ),
      ],
    );
  }
}

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
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'imageUrl', // Replace with your image asset
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'profileName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'location',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'postText',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    ),
  );
}
