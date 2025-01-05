import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furtime/controllers/profileController.dart';
import 'package:furtime/helpers/auth_api.dart';
import 'package:furtime/helpers/image_parser.dart';
import 'package:furtime/models/user_model.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var profileController = Get.put(ProfileController());
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _selectedImage;
  String? currentPicture;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize with existing user data
    _firstNameController.text = CURRENT_USER.value.firstName!;
    _lastNameController.text = CURRENT_USER.value.lastName!;
    _emailController.text = CURRENT_USER.value.email!;
    currentPicture = CURRENT_USER.value.photoUrl;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _submitProfile() async {
    // Handle profile submission logic here
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;

    var user = UserModel(
      firstName: firstName,
      lastName: lastName,
    );
    // Update user profile
    var updatedUser =
        await AuthApi.instance.updateProfile(user, _selectedImage);

    if (updatedUser) {
      profileController.allData();
      Get.snackbar('Success', "You have successfully updated your profile.");
      _toggleEditing(); // Disable editing after submission
    } else {
      Get.snackbar('Failed', "Failed to update your profile.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : currentPicture != null
                      ? NetworkImage(parseNetworkImage(currentPicture!))
                      : null, // Example asset image
              child: IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: _isEditing
                    ? () async {
                        _selectedImage = null;
                        _selectedImage = await pickImage();
                        setState(() {});
                      }
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // First Name Field
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 10),

            // Last Name Field
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 10),

            // Email Field (Read-Only)
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _toggleEditing,
                  child: Text(_isEditing ? "Cancel" : "Edit"),
                ),
                ElevatedButton(
                  onPressed: _isEditing ? _submitProfile : null,
                  child: const Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource
            .gallery, // Change to ImageSource.camera for camera input
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print("Image pick error: $e");
    }

    return null; // Return null if no image is picked
  }
}
