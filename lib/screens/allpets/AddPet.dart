import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furtime/helpers/db_sqflite.dart';
import 'package:furtime/models/pet_model.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/_constant.dart';

class additionalPet extends StatefulWidget {
  const additionalPet({super.key});

  @override
  State<additionalPet> createState() => _additionalPetState();
}

class _additionalPetState extends State<additionalPet> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final breedController = TextEditingController();
  final ageController = TextEditingController();

  String? gender;
  XFile? image;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    //
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: APP_THEME.value.colorScheme.secondary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Pet',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('To Add Pet, please enter the needed information.'),
                const Gap(12),
                TextFormField(
                  controller: fullNameController,
                  decoration: setTextDecoration('Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required.';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: ageController,
                  decoration: setTextDecoration('Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: breedController,
                  decoration: setTextDecoration('Breed'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                DropdownButtonFormField<String>(
                  value: gender,
                  items: ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                  ),
                ),
                const Gap(12),
                const Gap(12),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Choose Image'),
                ),
                if (image != null) Image.file(File(image!.path)),
                const Gap(12),
                ElevatedButton(
                  onPressed: () {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        // text: 'sample',
                        title: 'Are you Sure?',
                        confirmBtnText: 'Confirm',
                        cancelBtnText: 'Cancel',
                        onConfirmBtnTap: () async {
                          //
                          showLoadingModal(
                              label: "Adding Pet", text: "Please wait...");
                          var newPet = PetModel(
                            fullname: fullNameController.text,
                            age: int.parse(ageController.text),
                            breed: breedController.text,
                            gender: gender,
                            imageFile: image,
                          );
                          var petAtJson = await newPet.createPetJson();
                          int isSuccess =
                              await DatabaseHelper.instance.insert(petAtJson);
                          print(isSuccess);
                          if (isSuccess > 0) {
                            showSuccessModal(
                              label: "Success",
                              text: "You have successfully added pet.",
                              onPress: () {
                                Get.close(4);
                                Get.snackbar('Success',
                                    "You have successfully added pet.");
                              },
                            );
                          } else {
                            Get.close(1);
                            showFailedModal(
                              label: "Error",
                              text: "Failed to add pet.",
                            );
                          }

                          var result =
                              await DatabaseHelper.instance.queryAllRows();
                          var pets = PetModel.fromListJson(result);
                          ALL_PET_DATA.value = pets;
                        },
                        onCancelBtnTap: () {
                          Navigator.of(context).pop();
                        });
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration setTextDecoration(String name, {bool isPassword = false}) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      label: Text(name),
    );
  }
}
