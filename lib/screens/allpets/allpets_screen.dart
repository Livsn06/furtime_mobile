import 'package:flutter/material.dart';
import 'package:furtime/controllers/pet_screen_controller.dart';
import 'package:furtime/data/PetCard.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

class AllPetScreen extends StatefulWidget {
  const AllPetScreen({super.key});

  @override
  State<AllPetScreen> createState() => _AllPetScreenState();
}

class _AllPetScreenState extends State<AllPetScreen> {
  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    //
    return GetBuilder<PetScreenController>(
        init: PetScreenController(),
        builder: (controller) {
          return Obx(
            () {
              if (ALL_PET_DATA.value.isEmpty) {
                return Center(
                  child: Text(
                    '- No pets added yet -',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic),
                  ),
                );
              }
              return ListView.builder(
                itemCount: ALL_PET_DATA.value.length,
                itemBuilder: (context, index) {
                  var pet = ALL_PET_DATA.value[index];
                  return PetCard(
                    imageUrl: pet.imagePath!, // Replace with your image asset
                    petName: pet.fullname!,
                    age: "${pet.age}" " Yrs old",
                    breed: pet.breed!,
                    gender: pet.gender!,
                  );
                },
              );
            },
          );
        });
  }
}
