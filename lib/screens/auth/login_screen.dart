import 'package:flutter/material.dart';
import 'package:furtime/helpers/auth_api.dart';
import 'package:furtime/models/user_model.dart';
import 'package:furtime/screens/auth/signup_screen.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/widgets/build_modal.dart';
import 'package:get/get.dart';

import '../../storage/auth_storage.dart';
import '../../utils/_constant.dart';
import '../../utils/_utils.dart';
import '../../widgets/build_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isExistingUser = true.obs;
  var isCorrectPassword = true.obs;

  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APP_THEME.value.colorScheme.secondary,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Login'),
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
                    InitAssets.path.loginImage,
                    width: SCREEN_SIZE.value.width / 5,
                  ),

                  //
                  space(height: 20),
                  textFormInput(
                    label: 'Email',
                    isEmail: true,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }

                      if (!isExistingUser.value) {
                        return 'User does not exist';
                      }
                      return null;
                    },
                  ),
                  space(height: 20),
                  textFormInput(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      if (!isCorrectPassword.value) {
                        return 'Incorrect password';
                      }
                      return null;
                    },
                  ),
                  space(height: 30),

                  //
                  customButton(
                    label: 'Login',
                    onPress: () {
                      submitCredentials();
                    },
                  ),
                  space(height: 30),
                  authNavigation(
                    text: 'Don\'t have an account?',
                    label: 'Sign Up',
                    onPress: () {
                      Get.off(() => SignupScreen(), preventDuplicates: true);
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

  // LOGIN
  void submitCredentials() async {
    UserModel user = UserModel(
      email: emailController.text,
      password: passwordController.text,
    );

    isExistingUser.value = true;
    isCorrectPassword.value = true;
    //

    if (!formKey.currentState!.validate()) return;
    var result = await user.loginCredentials();

    if (result == true) {
      Get.offAll(() => HomeScreen());
      return;
    }

    if (result == 'User not found') {
      isExistingUser.value = false;

      //
    } else if (result == 'Incorrect password') {
      isCorrectPassword.value = false;
    }
    formKey.currentState!.validate();
  }
}
