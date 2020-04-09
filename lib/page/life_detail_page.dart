import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yumi_note/page/comment_module.dart';
import 'package:yumi_note/provider/comment_provider.dart';
import 'package:yumi_note/provider/life_provider.dart';
import 'package:yumi_note/widget/loading.dart';

class LifeDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LifeDetailState();
}

class LifeDetailState extends State {
  int postId = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (postId == -1) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context).settings.arguments;
      postId = arguments['postId'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LifeDetailProvider(postId),
        ),
        ChangeNotifierProvider(
          create: (_) => CommentProvider(
            commentType: CommentType.typeLife,
            id: postId.toString(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CommentAddProvider(
            commentType: CommentType.typeLife,
            id: postId.toString(),
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(40),
        color: Colors.white,
        child: ListView(
          children: [
            Consumer<LifeDetailProvider>(
              builder: (_, provider, ___) {
                return _buildContent(provider);
              },
            ),
            Consumer<LifeDetailProvider>(
              builder: (_, provider, ___) {
                return _buildImages(provider);
              },
            ),
            Container(height: 60),
            CommentSpin(),
            Container(height: 40),
            Consumer2<CommentProvider, CommentAddProvider>(
              builder: (_, commentProvider, commentAddProvider, ___) {
                return CommentListModule(
                    provider: commentProvider, addProvider: commentAddProvider);
              },
            ),
            Container(height: 30),
            Consumer<CommentAddProvider>(
              builder: (_, addProvider, ___) {
                return CommentInputModule(provider: addProvider);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(LifeDetailProvider provider) {
    return provider.life == null
        ? Container(height: 0)
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/yumi_header.png',
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
              Container(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.life.created,
                    style: TextStyle(fontSize: 14, color: Colors.black26),
                  ),
                  Container(height: 10),
                  Text(
                    provider.life.content,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ))
            ],
          );
  }

  Widget _buildImages(LifeDetailProvider provider) {
    return provider.life == null ||
            provider.life.images == null ||
            provider.life.images.isEmpty
        ? Container(height: 0)
        : GridView.count(
            shrinkWrap: true,
            crossAxisCount: provider.life.images.length,
            children: provider.life.images.map((e) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {},
                  child: Image.network(
                    e,
                    errorBuilder: (_, __, ___) {
                      return Image.asset('images/yumi_header.png');
                    },
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return DefaultLoading();
                    },
                  ),
                ),
              );
            }).toList(),
          );
  }
}
