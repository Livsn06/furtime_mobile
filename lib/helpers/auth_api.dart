import 'dart:convert';
import 'dart:developer';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

import '../storage/auth_storage.dart';
import '../utils/_constant.dart';

class AuthApi {
  static var instance = AuthApi();

  Future<String> signup(UserModel user) async {
    String baseURL = "${API_BASE_URL.value}/api/register";

    try {
      var response = await http.post(
        Uri.parse(baseURL),
        headers: {
          "Accept": "application/json",
          "ngrok-skip-browser-warning": "true"
        },
        body: user.toSignupJson(),
      );
      var result = jsonDecode(response.body);
      if (response.statusCode == 201) {
        log(result.toString(), name: "API RESULTS: ");
        return result['message'].toString();
      }

      log(result.toString(), name: "API RESULTS: ");
      return result['message'].toString();
    } catch (e) {
      log(e.toString(), name: "API ERROR: ");
      return 'Something went wrong';
    }
  }

  Future<dynamic> login(UserModel user) async {
    String baseURL = "${API_BASE_URL.value}/api/login";

    try {
      var response = await http.post(
        Uri.parse(baseURL),
        headers: {
          "Accept": "application/json",
          "ngrok-skip-browser-warning": "true"
        },
        body: user.toLoginJson(),
      );
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log(result.toString(), name: "API RESULTS: ");
        return UserModel.fromJson(result['data'], result['access_token']);
      }

      log(result.toString(), name: "API RESULTS: ");
      return result['message'].toString();
    } catch (e) {
      log(e.toString(), name: "API ERROR: ");
      return 'Something went wrong';
    }
  }

  Future<dynamic> session() async {
    String baseURL = "${API_BASE_URL.value}/api/session";
    String token = await AuthStorage.instance.getToken(
      name: AuthStorage.instance.login_token,
    );
    try {
      var response = await http.post(
        Uri.parse(baseURL),
        headers: {
          "Accept": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token"
        },
      );
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log(result.toString(), name: "API RESULTS: ");
        return UserModel.fromJson(result['data'], result['access_token']);
      }

      log(result.toString(), name: "API RESULTS: ");
      return result['message'].toString();
    } catch (e) {
      log(e.toString(), name: "API ERROR: ");
      return 'Something went wrong';
    }
  }

  Future<dynamic> logout() async {
    String baseURL = "${API_BASE_URL.value}/api/logout";
    String token = await AuthStorage.instance.getToken(
      name: AuthStorage.instance.login_token,
    );
    try {
      var response = await http.post(
        Uri.parse(baseURL),
        headers: {
          "Accept": "application/json",
          "ngrok-skip-browser-warning": "true",
          "Authorization": "Bearer $token"
        },
      );
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log(result.toString(), name: "API RESULTS: ");
        return true;
      }

      log(result.toString(), name: "API RESULTS: ");
      return result['message'].toString();
    } catch (e) {
      log(e.toString(), name: "API ERROR: ");
      return 'Something went wrong';
    }
  }
}
