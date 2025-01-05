import 'package:furtime/helpers/db_sqflite.dart';
import 'package:furtime/helpers/post_api.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

import '../models/reminderNotif.dart';

class CommentController extends GetxController {
  Future allData(int id) async {
    COMMENT_DATA.value = await PostApi.instance.showComment(postId: id);
  }
}
