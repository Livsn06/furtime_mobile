import 'dart:convert';
import 'dart:developer';

import 'package:furtime/models/post_model.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

import '../storage/auth_storage.dart';
import '../utils/_constant.dart';

class PostApi {
  static var instance = PostApi();

  Future<List<PostModel>> getAllPosts() async {
    String baseURL = "${API_BASE_URL.value}/api/posts";
    String token = await AuthStorage.instance.getToken(
      name: AuthStorage.instance.login_token,
    );
    try {
      var response = await http.get(
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
        return PostModel.fromListJson(result['data']);
      }

      log(result.toString(), name: "API RESULTS: ");
      return [];
    } catch (e) {
      log(e.toString(), name: "API ERROR: ");
      return [];
    }
  }

  Future<String> postBlog({required PostModel post, XFile? image}) async {
    String baseURL = "${API_BASE_URL.value}/api/posts";
    String token = await AuthStorage.instance.getToken(
      name: AuthStorage.instance.login_token,
    );
    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseURL));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['ngrok-skip-browser-warning'] = 'true';

      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image.path));
      }
      request.fields.addAll(post.createPostJson());

      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 201) {
        var data = await response.stream.bytesToString();
        var result = jsonDecode(data);
        log(result.toString(), name: "API RESULTS: ");
        return result['message'].toString();
      }

      //

      return 'Something went wrong';
    } catch (e) {
      log(e.toString(), name: "API ERROR: ");
      return 'Something went wrong';
    }
  }
}
