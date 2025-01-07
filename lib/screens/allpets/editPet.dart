import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furtime/helpers/db_sqflite.dart';
import 'package:furtime/models/pet_model.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/_constant.dart';

class EditPet extends StatefulWidget {
  EditPet({super.key, required this.pet});
  PetModel pet;
  @override
  State<EditPet> createState() => _additionalPetState();
}

class _additionalPetState extends State<EditPet> {
  @override
  void initState() {
    // TODO: implement initState

    fullNameController.text = widget.pet.fullname!;
    breedController.text = widget.pet.breed!;
    ageController.text = widget.pet.age!.toString();
    weightController.text = widget.pet.weight;
    colorController.text = widget.pet.color;
    lastVaccinationController.text = widget.pet.lastVaccinated;
    additionalInfoController.text = widget.pet.additionalInformation ?? '';
    gender = widget.pet.gender!;
    type = widget.pet.type;

    if (widget.pet.imagePath != null) {
      image = XFile(widget.pet.imagePath!);
    }

    DateTime parsedDate =
        DateFormat("MMM dd, yyyy").parse(widget.pet.lastVaccinated);
    String formattedDate = parsedDate.toUtc().toIso8601String();

    selectedDate = DateTime.parse(formattedDate);

    lastVaccinationController.text =
        DateFormat('MMM dd, yyyy').format(selectedDate!);

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final breedController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final colorController = TextEditingController();
  final lastVaccinationController = TextEditingController();
  final additionalInfoController = TextEditingController();

  String? gender;
  String? type;
  XFile? image;
  DateTime? selectedDate;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = pickedImage;
      }
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
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Pet',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
                Column(
                  children: [
                    InkWell(
                      onTap: _pickImage,
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: image == null
                            ? const Center(
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                const Gap(18),
                const Text(
                  'To Edit Pet, please enter the needed information.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                const Gap(12),
                TextFormField(
                  controller: fullNameController,
                  decoration: setTextDecoration('Full Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
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
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                DropdownButtonFormField<String>(
                  value: type,
                  items: ['Cat', 'Dog', 'Others'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value.toLowerCase(),
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Pet Type',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
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
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),

                const Gap(12),
                TextFormField(
                  controller: breedController,
                  decoration: setTextDecoration('Breed',
                      hintText: 'Labrador, Poodle, etc.'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: colorController,
                  decoration: setTextDecoration(
                    'Color',
                    hintText: 'Black, Brown etc.',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: weightController,
                  decoration: setTextDecoration(
                    'Weight',
                    hintText: 'Pet weight in lbs, kg etc.',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: lastVaccinationController,
                  readOnly: true,
                  decoration: setTextDecoration(
                    'Last Vaccination',
                    hintText: 'MM/DD/YYYY',
                    isCalendar: true,
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    if (selectedDate != null &&
                        !selectedDate!.isBefore(DateTime.now())) {
                      selectedDate = null;
                      return 'Last Vaccination cannot be in the future';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  maxLines: 3,
                  controller: additionalInfoController,
                  decoration: setTextDecoration(
                    'Additional Information (Optional)',
                    hintText:
                        'Description such as notes, medical conditions, allergies, etc.',
                  ),
                  keyboardType: TextInputType.text,
                ),
                //
                const Gap(12),
                const Gap(12),

                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    formKey.currentState!.save();

                    if (int.tryParse(ageController.text) == null) {
                      showFailedModal(
                        label: "Error",
                        text: "Age must be a number",
                      );
                      return;
                    }
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
                            id: widget.pet.id,
                            fullname: fullNameController.text,
                            age: int.parse(ageController.text),
                            breed: breedController.text,
                            gender: gender,
                            type: type!,
                            color: colorController.text,
                            weight: weightController.text,
                            lastVaccinated: lastVaccinationController.text,
                            additionalInformation:
                                additionalInfoController.text.isEmpty
                                    ? null
                                    : additionalInfoController.text,
                            imageFile: image,
                          );

                          int isSuccess =
                              await DatabaseHelper.instance.updatePet(newPet);

                          if (isSuccess > 0) {
                            Get.close(3);
                            Get.snackbar('Success',
                                "You have successfully updated pet.");
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
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        lastVaccinationController.text =

            //November 5, 2022
            DateFormat('MMM dd, yyyy').format(selectedDate!);
      });
    }
  }

  InputDecoration setTextDecoration(String name,
      {bool isPassword = false, bool isCalendar = false, String? hintText}) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      label: Text(name),
      hintText: hintText,
      hintStyle: hintText != null
          ? const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontStyle: FontStyle.italic,
            )
          : null,
      suffixIcon: isCalendar
          ? InkWell(
              onTap: _pickDate,
              child: const Icon(Icons.calendar_month),
            )
          : null,
    );
  }
}
