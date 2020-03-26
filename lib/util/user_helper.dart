import 'package:dio/dio.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:yumi_note/model/github_user.dart';
import 'package:yumi_note/network/api.dart';
import 'package:yumi_note/util/app_info.dart';

class UserHelper {
  const UserHelper._();

  static Future<GithubUser> readUserFromSP() async {
    Map<String, Object> map = await SharedPreferencesPlugin().getAll();
    AppInfo.getInstance().setUerInfo(map['user']);
    return map['user'];
  }

  static Future<GithubUser> getGithubUserInfo(String accessToken) async {
    Response resp = await Dio().get(Api.getGithubUserInfo, queryParameters: {
      'access_token': accessToken,
    });
    GithubUser user = GithubUser();
    user.accessToken = resp.data['accessToken'];
    user.login = resp.data['login'];
    user.id = resp.data['id'];
    user.name = resp.data['name'];
    user.avatarUrl = resp.data['avatarUrl'];
    AppInfo.getInstance().setUerInfo(user);
    await SharedPreferencesPlugin().setValue('String', 'user', user);
    return user;
  }
}
