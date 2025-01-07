import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../helpers/auth_api.dart';
import '../storage/auth_storage.dart';
import '../utils/_constant.dart';
import '../widgets/build_modal.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
  int? uid;
  String? photoUrl;

  String? access_token;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.uid,
    this.photoUrl,
    this.password,
    this.confirmPassword,
    this.access_token,
  });

  Map<String, String> toJson() {
    var json = <String, String>{};
    json['email'] = arrangeEmail();
    json['password'] = password!;
    return json;
  }

  UserModel.fromJson(Map<String, dynamic> json, String token) {
    json = json ?? {};
    uid = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    photoUrl = json['profile'];
    access_token = token;
  }

  Map<String, String> toLoginJson() {
    var json = <String, String>{};
    json['email'] = arrangeEmail();
    json['password'] = password!;
    return json;
  }

  Map<String, String> toSignupJson() {
    var json = <String, String>{};
    json['first_name'] = arrangeName(firstName);
    json['last_name'] = arrangeName(lastName);
    json['email'] = arrangeEmail();
    json['password'] = password!;
    return json;
  }

  Map<String, String> toUpdateJson() {
    var json = <String, String>{};
    json['first_name'] = arrangeName(firstName);
    json['last_name'] = arrangeName(lastName);
    return json;
  }

  String arrangeEmail() {
    return email!.trim().toLowerCase();
  }

  String arrangeName(value) {
    return GetUtils.capitalizeFirst(value.toString()).toString().trim();
  }

  bool isPasswordMatch() {
    return password == confirmPassword;
  }

  //

  Future<dynamic> loginCredentials() async {
    //

    showLoadingModal(label: "Login", text: "Please wait...");
    UserModel user = UserModel(email: email, password: password);
    //
    var result = await AuthApi.instance.login(user);
    Get.close(1);

    if (result is UserModel && result.access_token != null) {
      Get.snackbar('Success', "You have successfully login.");
      //
      AuthStorage.instance.setToken(
        name: AuthStorage.instance.login_token,
        token: result.access_token,
      );

      CURRENT_USER.value = result;
      //
      return true;
    } else if (result == "User not found") {
      return 'User not found';
    } else if (result == "Incorrect password") {
      return 'Incorrect password';
    }
    //
    showFailedModal(
      label: "Error",
      text: result.toString(),
    );
    return 'Something went wrong';
  }

  Future<dynamic> signupCredentials() async {
    //

    showLoadingModal(label: "Signup", text: "Please wait...");
    UserModel user = UserModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    //
    var result = await AuthApi.instance.signup(user);
    Get.close(1);

    if (result == "success") {
      Get.snackbar('Success', "You have successfully register.");
      return true;
    } else if (result == "User already exists") {
      return 'User already exists';
    } else if (result == "Registration failed") {
      showFailedModal(
        label: "Registration failed",
        text: 'Please try again',
      );
    }
    //
    showFailedModal(
      label: "Error",
      text: result.toString(),
    );
    return 'Something went wrong';
  }
}
