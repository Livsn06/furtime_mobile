import 'dart:developer';

import 'package:furtime/models/comment_model.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/post_api.dart';
import 'user_model.dart';

class PostModel {
  int? id;
  String? title;
  String? description;
  String? image;
  UserModel? user;
  int comments;
  String? createdAt;
  String? updatedAt;
  PostModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.user,
    this.comments = 0,
    this.createdAt,
    this.updatedAt,
  });

  static List<PostModel> fromListJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    }

    return json.map((e) => PostModel.fromJson(e)).toList();
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['images'],
      user: UserModel.fromJson(json['user'], ""),
      comments: json['comments'].length ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, String> createPostJson() {
    var json = <String, String>{};
    json['title'] = title.toString();
    json['description'] = description.toString();
    return json;
  }

  Future<bool> postBlog({XFile? image}) async {
    var result = await PostApi.instance.postBlog(
      post: this,
      image: image,
    );

    if (result == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
