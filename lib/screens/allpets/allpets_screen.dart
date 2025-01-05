import 'package:flutter/material.dart';
import 'package:furtime/controllers/pet_screen_controller.dart';
import 'package:furtime/data/PetCard.dart';
import 'package:furtime/helpers/db_sqflite.dart';
import 'package:furtime/screens/allpets/viewHelp.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/widgets/build_modal.dart';
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
                padding: const EdgeInsets.all(6.0),
                itemBuilder: (context, index) {
                  var pet = ALL_PET_DATA.value[index];
                  return Dismissible(
                    key: Key(pet.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      showConfirmModal(
                        context,
                        label: "Delete Pet",
                        text: "Are you sure you want to delete this pet?",
                        onConfirm: () async {
                          await DatabaseHelper.instance.deletePet(pet.id!);
                          controller.allData();
                          Get.close(1);
                          return true;
                        },
                      );
                      return false;
                    },
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ViewHelpScreen(petType: pet.type));
                      },
                      child: PetCard(
                        imageUrl:
                            pet.imagePath!, // Replace with your image asset
                        petName: pet.fullname!,
                        age: "${pet.age}" " Yrs old",
                        breed: pet.breed!,
                        type: pet.type,
                        gender: pet.gender!,
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
