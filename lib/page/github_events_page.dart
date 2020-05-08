import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yumi_note/model/github_events.dart';
import 'package:yumi_note/provider/github_events_provider.dart';
import 'package:yumi_note/util/date_helper.dart';

class GithubEventsPage extends StatelessWidget {
  Widget get title => Text('Github Events',
      style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          height: 3,
          fontFamily: 'Monaco'));

  Widget get empty =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        title,
        Text('没有任何Github活动数据哦~',
            style: TextStyle(
                color: Colors.pinkAccent, fontSize: 18, fontFamily: 'Monaco')),
      ]);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GithubEventsProvider>(
      create: (_) => GithubEventsProvider(),
      child: Builder(builder: (ctx) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: Provider.of<GithubEventsProvider>(ctx).events.length + 1,
            itemBuilder: (_, index) {
              List<GithubEvent> events =
                  Provider.of<GithubEventsProvider>(ctx).events;
              String today =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              int count = events
                  .where((element) => element.createdAt.formatToDay() == today)
                  .length;
              if (index == 0) {
                return events.length == 0
                    ? empty
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title,
                          Text('$count commits today.',
                              style: TextStyle(
                                  color: Colors.pinkAccent,
                                  fontSize: 20,
                                  fontFamily: 'Monaco')),
                          Container(height: 20)
                        ],
                      );
              }
              GithubEvent event = events[index - 1];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(_getIcon(event.type),
                          color: Colors.pinkAccent, size: 16),
                      Container(width: 2, height: 42, color: Colors.black12),
                    ],
                  ),
                  Container(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getEventString(event),
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                          maxLines: 1,
                        ),
                        Container(height: 8),
                        Text(
                          _getEventDetail(event),
                          style: TextStyle(color: Colors.black45),
                          maxLines: 2,
                        ),
                        Container(height: 10),
                      ],
                    ),
                  ),
                  Text(event.createdAt.formatToDay(),
                      style: TextStyle(color: Colors.black26)),
                ],
              );
            });
      }),
    );
  }

  String _getEventDetail(GithubEvent event) {
    switch (event.type) {
      case 'CreateEvent':
        return event.repo.name;
        break;
      case 'WatchEvent':
        return event.repo.name;
        break;
      case 'PushEvent':
        return event.repo.name;
        break;
      case 'IssuesEvent':
        return event.payload.issue['title'];
        break;
      case 'IssueCommentEvent':
        return event.payload.issue['title'];
        break;
      case 'MemberEvent':
        return event.repo.name;
      default:
        return event.repo.name;
        break;
    }
  }

  String _getEventString(GithubEvent event) {
    switch (event.type) {
      case 'CreateEvent':
        return 'Create a repository';
        break;
      case 'WatchEvent':
        return event.payload.action;
        break;
      case 'PushEvent':
        return 'Commit to repository';
        break;
      case 'IssuesEvent':
        return 'Create a issue on ${event.repo.name}';
        break;
      case 'IssueCommentEvent':
        return 'Comment on issue';
        break;
      case 'MemberEvent':
        return 'Add member ${event.payload.member['login']} to';
        break;
      default:
        return 'Update ';
        break;
    }
  }

  IconData _getIcon(String eventType) {
    switch (eventType) {
      case 'CreateEvent':
        return Icons.add_circle;
        break;
      case 'WatchEvent':
        return Icons.remove_red_eye;
        break;
      case 'PushEvent':
        return Icons.backup;
        break;
      case 'IssuesEvent':
        return Icons.help;
        break;
      case 'IssueCommentEvent':
        return Icons.comment;
        break;
      case 'MemberEvent':
        return Icons.person_add;
        break;
      default:
        return Icons.call_to_action;
        break;
    }
  }
}
