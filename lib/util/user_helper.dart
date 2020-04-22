import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumi_note/model/github_user.dart';
import 'package:yumi_note/network/api.dart';
import 'package:yumi_note/network/dio_client.dart';
import 'package:yumi_note/util/app_info.dart';
import 'dart:convert' as convert;

class UserHelper {

  static const String SP_USER_KEY = 'flutter.user';
  const UserHelper._();

  static Future<GithubUser> readUserFromSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userStr = sp.get(SP_USER_KEY);
    if (userStr != null) {
      Map<String, dynamic> userMap = convert.jsonDecode(sp.get(SP_USER_KEY));
      GithubUser user = GithubUser.fromJson(userMap);
      debugPrint('user.name = ${user.name}');
      AppInfo.getInstance().setUerInfo(user);
      return user;
    }
    return null;
  }

  static Future<void> getGithubUserInfo(String accessToken) async {
    await DioClient.get(Api.getGithubUserInfo, queryParameters: {
      'access_token': accessToken,
    }, success: (resp) async {
      GithubUser user = GithubUser.fromJson(resp);
      AppInfo.getInstance().setUerInfo(user);
      debugPrint('user.name = ${user.name}');
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userStr = convert.jsonEncode(resp);
      sp.setString(SP_USER_KEY, userStr);
    });
  }
}
