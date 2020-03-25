import 'package:flutter/material.dart';

class AboutMePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMePage> {
  final titleStyle = TextStyle(fontSize: 18, color: Colors.pink);
  final bodyStyle =
      TextStyle(fontSize: 16, color: Color(0xCC000000), height: 2);
  final double blocMargin = 40.0;
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
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.all(40),
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.bubble_chart,
                color: Colors.pink,
              ),
              Text(
                '关于本站',
                style: titleStyle,
              ),
            ],
          ),
          Container(
            height: 20,
          ),
          Text(
            '小破站前端部分纯Flutter搭建，\n'
            '后端部分使用Go，\n'
            '综合起来就是一句话，Google爸爸真香。\n'
            '数据同步自掘金，图床用的Gitee。',
            style: bodyStyle,
          ),
          Container(
            height: blocMargin,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.bubble_chart,
                color: Colors.pink,
              ),
              Text(
                '关于我',
                style: titleStyle,
              ),
            ],
          ),
          Container(
            height: 20,
          ),
          Text(
            '萌新，很萌很新。\n'
            '没呆过什么牛逼的公司，不喜欢加班，目前国企养老。\n'
            '无欲无求，只想早点下班回家看儿砸。\n'
            '啊，儿砸太可爱了，哈哈哈哈哈哈哈。',
            style: bodyStyle,
          ),
          Container(
            height: blocMargin,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.bubble_chart,
                color: Colors.pink,
              ),
              Text(
                '联系我？',
                style: titleStyle,
              ),
            ],
          ),
          Container(
            height: 20,
          ),
          Text(
            '男生请加左👈👈👈，女生请加右👉👉👉，谢谢',
            style: bodyStyle,
          ),
          Container(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Image.network(
                'https://gitee.com/yumi0629/ImageAsset/raw/master/yumi_note/qq_yumi.jpeg',
                width: 150,
                height: 180,
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return loading;
                },
              ),
              Container(
                width: 20,
              ),
              Image.network(
                'https://gitee.com/yumi0629/ImageAsset/raw/master/yumi_note/qq_yumi.jpeg',
                width: 150,
                height: 180,
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return loading;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
