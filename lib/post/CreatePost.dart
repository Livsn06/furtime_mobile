import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/utils/_utils.dart';
import 'package:furtime/widgets/build_form.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/build_modal.dart';

class Createpost extends StatefulWidget {
  const Createpost({super.key});

  @override
  State<Createpost> createState() => _CreatepostState();
}

class _CreatepostState extends State<Createpost> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  //
  bool showPassword = true;
  String? gender;
  List<XFile>? image;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickMultiImage();
    setState(() {
      image = pickedImage.isNotEmpty ? pickedImage : null;
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
          'Create Post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
                const Text('To Post, please enter the needed information.'),
                const Gap(12),
                textFormInput(
                  label: 'Title',
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                textFormInput(
                  label: 'Description',
                  maxLine: 5,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                space(height: SCREEN_SIZE.value.height / 20),
                customImageViewer(),
                const Gap(12),
                customButton(
                  label: 'Post',
                  onPress: () => showSuccessModal(
                    label: 'Success',
                    text: 'Post Created Successfully',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customImageViewer() {
    return SizedBox(
      height: 60,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: image == null ? 1 : image!.length + 1,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 90,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return MaterialButton(
              onPressed: _pickImage,
              color: Colors.white,
              elevation: 4,
              child: const Icon(
                Icons.add_photo_alternate_outlined,
              ),
            );
          } else {
            return InkWell(
              onTap: () => showImageModal(image![index - 1]),
              child: Image.file(
                File(image![index - 1].path),
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
    );
  }
}
