import 'package:yumi_note/model/github_user.dart';

class AppInfo {
  AppInfo._();

  GithubUser user;

  static AppInfo _instance;

  static AppInfo getInstance() {
    if (_instance == null) {
      _instance = AppInfo._();
    }
    return _instance;
  }

  void setUerInfo(GithubUser user) {
    _instance.user = user;
  }
}
