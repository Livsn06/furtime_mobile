import 'dart:io';

import 'package:furtime/helpers/db_sqflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../helpers/post_api.dart';
import 'user_model.dart';

class PetModel {
  int? id;
  String? fullname;
  String? breed;
  String? gender;
  int? age;
  String? imagePath;
  XFile? imageFile;

  String? createdAt;
  PetModel({
    this.id,
    this.fullname,
    this.breed,
    this.gender,
    this.age,
    this.imagePath,
    this.imageFile,
    this.createdAt,
  });

  static List<PetModel> fromListJson(List<Map<String, dynamic>> json) {
    if (json.isEmpty) {
      return [];
    }

    return json.map((e) => PetModel.fromJson(e)).toList();
  }

  factory PetModel.fromJson(Map<String, dynamic> json) {
    var dbHelper = DatabaseHelper();
    print(json.toString());
    return PetModel(
      id: json[dbHelper.id],
      fullname: json[dbHelper.fullname],
      breed: json[dbHelper.breed],
      gender: json[dbHelper.gender],
      age: json[dbHelper.age],
      imagePath: json[dbHelper.imagePath],
    );
  }

  Future<Map<String, String>> createPetJson() async {
    var dbHelper = DatabaseHelper();

    var json = <String, String>{};
    json[dbHelper.fullname] = fullname.toString();
    json[dbHelper.breed] = breed.toString();
    json[dbHelper.gender] = gender.toString();
    json[dbHelper.age] = age.toString();
    json[dbHelper.imagePath] = await pickAndStoreImage();
    return json;
  }

  Future<String> pickAndStoreImage() async {
    try {
      if (imageFile == null) {
        return "";
      }
      // Convert XFile to File
      File convertedFile = File(imageFile!.path);

      // Get the app's documents directory
      final directory = await getApplicationDocumentsDirectory();
      final targetFolder = "${directory.path}/MyPetImages";

      // Ensure the folder exists
      final folder = Directory(targetFolder);
      if (!folder.existsSync()) {
        folder.createSync(recursive: true);
      }

      // Define the new file path
      final newFilePath =
          "$targetFolder/${DateTime.now().millisecondsSinceEpoch}.png";

      // Copy the file to the new location
      final storedFile = await convertedFile.copy(newFilePath);
      return storedFile.path;
    } catch (e) {
      print("Error: $e");
      return "";
    }
  }
}
