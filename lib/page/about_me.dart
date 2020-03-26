import 'package:flutter/material.dart';
import 'package:yumi_note/model/about_me.dart';
import 'package:yumi_note/network/api.dart';
import 'package:yumi_note/network/dio_client.dart';

class AboutMePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMePage>
    with AutomaticKeepAliveClientMixin {
  List<Introduction> introduction = List();

  @override
  bool get wantKeepAlive => true;

  final titleStyle = TextStyle(fontSize: 18, color: Colors.pink);
  final bodyStyle =
      TextStyle(fontSize: 16, color: Color(0xCC000000), height: 2);
  final loading = SizedBox(
    width: 150,
    height: 180,
    child: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    DioClient.get('${Api.aboutMe}', success: (data) {
      (data as List).forEach((element) {
        introduction.add(Introduction.fromJson(element));
      });
      setState(() {});
    });
  }

  List<Widget> _buildContent() {
    Widget bloc40 = Container(
      height: 40.0,
    );
    Widget bloc20 = Container(
      height: 20.0,
    );
    List<Widget> content = List();
    introduction.forEach(
      (element) {
        content
          ..add(
            Row(
              children: <Widget>[
                Icon(
                  Icons.bubble_chart,
                  color: Colors.pink,
                ),
                Text(
                  element.title,
                  style: titleStyle,
                ),
              ],
            ),
          )
          ..add(bloc20)
          ..add(
            Text(
              element.content,
              style: bodyStyle,
            ),
          )
          ..add(bloc40);
        if (element.image != null) {
          List<Widget> images = List();
          element.image.forEach((image) {
            images
              ..add(
                Image.network(
                  image,
                  width: 150,
                  height: 180,
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return loading;
                  },
                ),
              )
              ..add(
                Container(
                  width: 20,
                ),
              );
          });
          content.add(
            Row(
              children: images,
            ),
          );
        }
      },
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: ListView(
          padding: EdgeInsets.all(40),
          children: (introduction.isEmpty) ? [Container()] : _buildContent()),
    );
  }
}
