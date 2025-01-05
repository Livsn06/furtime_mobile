import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furtime/controllers/home_screen_controller.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:furtime/utils/_utils.dart';
import 'package:furtime/widgets/build_form.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/post_model.dart';
import '../../widgets/build_modal.dart';

class Createpost extends StatefulWidget {
  const Createpost({super.key});

  @override
  State<Createpost> createState() => _CreatepostState();
}

class _CreatepostState extends State<Createpost> {
  final homeController = HomeScreenController();

  //
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  //
  bool showPassword = true;
  String? gender;
  List<XFile> image = [];

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      image.add(pickedImage);
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
                  hintColor: Colors.grey,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required. Please enter a title';
                    }
                    return null;
                  },
                ),
                const Gap(12),
                textFormInput(
                  label: 'Description',
                  maxLine: 5,
                  controller: descriptionController,
                  hintColor: Colors.grey,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required. Please enter a description';
                    }
                    return null;
                  },
                ),
                space(height: SCREEN_SIZE.value.height / 20),
                customImageViewer(),
                const Gap(12),
                customButton(
                    label: 'Post',
                    color: Colors.deepOrange,
                    onPress: () async {
                      if (!formKey.currentState!.validate()) return;

                      var post = PostModel(
                        title: titleController.text,
                        description: descriptionController.text,
                      );

                      //
                      showLoadingModal(
                        label: 'Posting',
                        text: 'Please wait...',
                      );

                      if (await post.postBlog(
                          image: (image.isNotEmpty) ? image[0] : null)) {
                        Get.snackbar('Success', 'Post created successfully');
                        Get.close(2);

                        //
                      } else {
                        Get.close(1);
                        showFailedModal(
                          label: 'Error',
                          text: 'Something went wrong',
                        );
                      }
                      //
                      homeController.allData();
                    })
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
        itemCount: image == null ? 1 : image.length + 1,
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
              onTap: () => showImageModal(image[index - 1]),
              child: Image.file(
                File(image[index - 1].path),
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
    );
  }
}
