import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PetCard extends StatelessWidget {
  final String petName;
  final String age;
  final String breed;
  final String gender;
  final String type;
  final String imageUrl;

  const PetCard({
    super.key,
    required this.petName,
    required this.age,
    required this.breed,
    required this.gender,
    required this.type,
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
                  child: imageUrl.isNotEmpty && File(imageUrl).existsSync()
                      ? Image.file(
                          alignment: Alignment.topCenter,
                          File(imageUrl),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Icon(
                            Icons.pets,
                            size: 200,
                          ),
                        )),
              const Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        petName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '$breed [${GetUtils.capitalizeFirst(type)}]',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
      ),
    );
  }
}
