import 'package:furtime/helpers/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthStorage extends TokenNames {
  static var instance = AuthStorage();

  void setToken({name, token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, token);
  }

  Future<String> getToken({name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name) ?? '';
  }

  dynamic verifyExistingToken() async {
    var token = await AuthApi.instance.session();
    return (token is UserModel) ? token : false;
  }
}

class TokenNames {
  String login_token = 'login_token';
}
