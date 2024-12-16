
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:image_picker/image_picker.dart';
class createPost
 extends StatefulWidget {
  const createPost({super.key});

  @override
  State<createPost> createState() => _createPostState();
}

class _createPostState extends State<createPost> {
  final formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool showPassword = true;
   final lastName = TextEditingController();
  String? gender;
  XFile? image;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.amber[400],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Create Post',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                const Text(
                    'To Post, please enter the needed information.'),
                const Gap(12),
                TextFormField(
                  controller: firstName,
                  decoration: setTextDecoration('Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required.';
                    }
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: lastName,
                  decoration: setTextDecoration('Description'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                  },
                ),     const Gap(12),
              
                      const Gap(12),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Choose Image'),
                ),
                if (image != null)
                  Image.file(File(image!.path)),
    
                const Gap(12),
                ElevatedButton(
                  onPressed: (){
                     QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  // text: 'sample',
                  title: 'Are you Sure?',
                  confirmBtnText: 'Confirm',
                  cancelBtnText: 'Cancel',
                  onConfirmBtnTap: () {
                      Navigator.of(context).pop();
                  // Navigator.of(context).push(
                  // MaterialPageRoute(builder: (_) => AllPets()));
                  },
                    onCancelBtnTap: () {
                     Navigator.of(context).pop();}
                    );
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



