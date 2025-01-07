import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furtime/models/reminderNotif.dart';
import 'package:furtime/models/comment_model.dart';
import 'package:furtime/models/pet_model.dart';
import 'package:furtime/models/post_model.dart';
import 'package:furtime/models/task_model.dart';
import 'package:furtime/models/user_model.dart';
import 'package:get/get.dart';

Rx<UserModel> CURRENT_USER = Rx<UserModel>(UserModel());
Rx<Size> SCREEN_SIZE = Rx<Size>(const Size(0, 0));
Rx<ThemeData> APP_THEME = Rx<ThemeData>(ThemeData.light());
Rx<String> APP_TITLE = Rx<String>(dotenv.env['APP_TITLE'] ?? 'Unknown');
Rx<String> API_BASE_URL = Rx<String>(dotenv.env['API_BASE_URL'] ?? 'Unknown');

RxList<PostModel> ALL_POST_DATA = RxList<PostModel>([]);
RxList<PetModel> ALL_PET_DATA = RxList<PetModel>([]);
RxList<TaskModel> ALL_TODO_DATA = RxList<TaskModel>([]);

RxList<Reminder> ALL_CALENDAR_DATA = RxList<Reminder>([]);

RxList<CommentModel> COMMENT_DATA = RxList<CommentModel>([]);

RxList<TaskModel> completedList = RxList([]);
RxList<TaskModel> IncompletedList = RxList([]);
RxString FILTERTYPE = 'ALL'.obs;

RxInt navigationPage = 0.obs;
