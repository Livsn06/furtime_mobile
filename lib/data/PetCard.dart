import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PetCard extends StatelessWidget {
  final String petName;
  final String age;
  final String breed;
  final String gender;
  final String imageUrl;

  const PetCard({
    super.key,
    required this.petName,
    required this.age,
    required this.breed,
    required this.gender,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(imageUrl), // Replace with your image asset
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            petName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(190),
                          Text(
                            breed,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            age,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const Gap(170),
                          Text(
                            gender,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
