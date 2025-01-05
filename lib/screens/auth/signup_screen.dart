import 'package:flutter/material.dart';
import 'package:furtime/helpers/auth_api.dart';
import 'package:furtime/models/user_model.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';

import '../../storage/auth_storage.dart';
import '../../utils/_constant.dart';
import '../../utils/_utils.dart';
import '../../widgets/build_form.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isExistingUser = false.obs;
  var isPasswordMatch = true.obs;

  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: SizedBox(
        width: SCREEN_SIZE.value.width,
        height: SCREEN_SIZE.value.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SCREEN_SIZE.value.width / 60,
                vertical: SCREEN_SIZE.value.width / 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  Image.asset(
                    InitAssets.path.signupImage,
                    width: SCREEN_SIZE.value.width / 5,
                  ),

                  //
                  space(height: SCREEN_SIZE.value.height / 40),

                  textFormInput(
                    label: 'First name',
                    controller: firstNameController,
                    hintColor: Colors.grey,
                    isName: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }

                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'First name containing only letters';
                      }

                      return null;
                    },
                  ),
                  space(height: SCREEN_SIZE.value.height / 40),

                  textFormInput(
                    label: 'Last name',
                    controller: lastNameController,
                    isName: true,
                    hintColor: Colors.grey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }

                      // alpabhet with string
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Last name containing only letters';
                      }

                      return null;
                    },
                  ),
                  space(height: SCREEN_SIZE.value.height / 40),
                  textFormInput(
                    label: 'Email',
                    isEmail: true,
                    controller: emailController,
                    hintColor: Colors.grey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }

                      if (isExistingUser.value) {
                        return 'User already exists';
                      }
                      return null;
                    },
                  ),
                  space(height: SCREEN_SIZE.value.height / 40),
                  textFormInput(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    hintColor: Colors.grey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      if (!isPasswordMatch.value) {
                        return 'Confirm password does not match';
                      }
                      return null;
                    },
                  ),
                  space(height: SCREEN_SIZE.value.height / 40),
                  textFormInput(
                    label: 'Confirm Password',
                    isPassword: true,
                    controller: confirmPasswordController,
                    hintColor: Colors.grey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }

                      if (!isPasswordMatch.value) {
                        return 'Confirm password does not match';
                      }

                      return null;
                    },
                  ),
                  space(height: SCREEN_SIZE.value.height / 30),

                  //
                  customButton(
                    label: 'Sign Up',
                    color: Colors.deepOrange,
                    onPress: () {
                      submitCredentials();
                    },
                  ),
                  space(height: SCREEN_SIZE.value.height / 90),
                  authNavigation(
                    text: 'Already have an account?',
                    label: 'Log in',
                    onPress: () {
                      Get.off(() => LoginScreen(), preventDuplicates: true);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //register
  void submitCredentials() async {
    UserModel user = UserModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    isExistingUser.value = false;
    isPasswordMatch.value = true;
    //

    if (!formKey.currentState!.validate()) return;

    if (!user.isPasswordMatch()) {
      isPasswordMatch.value = false;
      formKey.currentState!.validate();
      return;
    }

    //
    var result = await user.signupCredentials();

    if (result == true) {
      Get.to(() => LoginScreen());
      return;
    }

    if (result == 'User already exists') {
      isExistingUser.value = true;

      //
    }
    formKey.currentState!.validate();
  }
}
