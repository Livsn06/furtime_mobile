import 'package:furtime/models/user_model.dart';

class CommentModel {
  final int id;
  final int postId;
  final UserModel user;
  final String body;
  final String createdAt;
  final String updatedAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.user,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });

  static List<CommentModel> fromListJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [];
    }
    return json.map((e) => CommentModel.fromJson(e)).toList();
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['post_id'],
      user: UserModel.fromJson(json['user'], ''),
      body: json['body'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId.toString(),
      'user_id': user.uid.toString(),
      'body': body.toString(),
    };
  }
}
