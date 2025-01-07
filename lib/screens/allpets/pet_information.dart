import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furtime/controllers/pet_screen_controller.dart';
import 'package:furtime/helpers/db_sqflite.dart';
import 'package:furtime/models/pet_model.dart';
import 'package:furtime/screens/allpets/editPet.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PetInfoScreen extends StatefulWidget {
  final PetModel pet;

  const PetInfoScreen({super.key, required this.pet});

  @override
  _PetInfoScreenState createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  var controller = Get.put(PetScreenController());
  final fullNameController = TextEditingController();
  final breedController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final colorController = TextEditingController();
  final lastVaccinationController = TextEditingController();
  final additionalInfoController = TextEditingController();
  late File? image;
  @override
  void initState() {
    super.initState();

    try {
      var vaccinatedFormat =
          DateFormat('yyyy-MM-dd').parse(widget.pet.lastVaccinated);
      lastVaccinationController.text =
          DateFormat('MM-dd-yyyy').format(vaccinatedFormat).toString();
    } catch (e) {
      // Fallback if the date format is incorrect
      print("Error parsing date: $e");
      lastVaccinationController.text =
          widget.pet.lastVaccinated; // Display as-is if invalid
    }

    // Continue with other initializations
    fullNameController.text = widget.pet.fullname ?? '';
    breedController.text = widget.pet.breed ?? '';
    ageController.text = widget.pet.age?.toString() ?? '';
    weightController.text = widget.pet.weight;
    colorController.text = widget.pet.color;
    additionalInfoController.text = widget.pet.additionalInformation ?? '';

    if (widget.pet.imageFile == null) {
      image = widget.pet.imagePath == null ? null : File(widget.pet.imagePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Pet Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: image != null || image!.path.isNotEmpty
                      ? DecorationImage(
                          alignment: Alignment.topCenter,
                          image: FileImage(image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: image == null || image!.path.isEmpty
                    ? const Icon(
                        Icons.pets,
                        size: 100,
                      )
                    : null,
              ),
              const Gap(30),
              TextField(
                readOnly: true,
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const Gap(14),
              TextField(
                readOnly: true,
                controller: breedController,
                decoration: const InputDecoration(labelText: 'Breed'),
              ),
              const Gap(14),
              TextField(
                readOnly: true,
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const Gap(14),
              TextField(
                readOnly: true,
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight'),
              ),
              const Gap(14),
              TextField(
                readOnly: true,
                controller: colorController,
                decoration: const InputDecoration(labelText: 'Color'),
              ),
              const Gap(14),
              TextField(
                readOnly: true,
                controller: lastVaccinationController,
                decoration:
                    const InputDecoration(labelText: 'Last Vaccination'),
              ),
              const Gap(14),
              TextField(
                readOnly: true,
                controller: additionalInfoController,
                decoration:
                    const InputDecoration(labelText: 'Additional Information'),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      print(widget.pet.id);
                      showConfirmModal(
                        context,
                        label: "Delete Pet",
                        text: "Are you sure you want to delete this pet?",
                        onConfirm: () async {
                          await DatabaseHelper.instance
                              .deletePet(widget.pet.id!);
                          controller.allData();
                          Get.close(2);
                          return true;
                        },
                      );
                    },
                    child: const Text('Delete'),
                  ),
                  const Gap(10),
                  MaterialButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () {
                      Get.off(() => EditPet(pet: widget.pet));
                    },
                    child: const Text('Edit'),
                  ),
                  const Gap(10),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      Get.close(1);
                      navigationPage.value = 2;
                    },
                    child: const Text('Go to Tasks'),
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
