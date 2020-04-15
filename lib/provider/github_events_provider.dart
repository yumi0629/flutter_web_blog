import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yumi_note/model/github_events.dart';
import 'package:yumi_note/network/api.dart';

class GithubEventsProvider with ChangeNotifier {
  List<GithubEvent> events = [];

  GithubEventsProvider() {
    getGithubEvents();
  }

  void getGithubEvents() {
    Dio(BaseOptions(headers: {'Authorization': 'token ${Api.githubToken}'}))
      ..interceptors.add(InterceptorsWrapper(
        onError: (e) {
          debugPrint('Dio error with request: ${e.request.uri}');
          debugPrint('Request data: ${e.request.data}');
          debugPrint('Dio error: ${e.message}');
          return e;
        },
      ))
      ..get(Api.getGithubEvents).then((resp) {
        if (resp.statusCode == 200) {
          events = getGithubEventList(resp.data);
          notifyListeners();
        }
      });
  }
}
