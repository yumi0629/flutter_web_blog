import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';
import 'package:yumi_note/model/life.dart';
import 'package:yumi_note/provider/life_provider.dart';
import 'dart:ui' as ui;
import 'package:yumi_note/util/route.dart';
import 'package:yumi_note/widget/loading.dart';

class MyLifePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyLifeState();
}

class MyLifeState extends State<MyLifePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LifeListProvider(),
        ),
      ],
      child: Consumer<LifeListProvider>(builder: (_, provider, __) {
        return LoadingMoreList(
          ListConfig<Life>(
            extendedListDelegate:
                SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
            sourceList: provider.listRepository,
            padding: EdgeInsets.all(16),
            indicatorBuilder: _buildIndicator,
            itemBuilder: (ctx, life, index) {
              return GestureDetector(
                onTap: () {
                  LifeNavHelper.pushNamed(RouteName.lifeDetail, arguments: {
                    'postId': life.postId,
                  });
                },
                child: _buildItem(life),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildItem(Life life) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            life.images.isEmpty
                ? Image.asset('images/yumi_header.png')
                : Image.network(
                    life.images[0],
                    errorBuilder: (_, __, ___) {
                      return Image.asset('images/yumi_header.png');
                    },
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return DefaultLoading();
                    },
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black12,
                    padding: EdgeInsets.all(10),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      life.content,
                      maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
    Widget widget;
    switch (status) {
      case IndicatorStatus.error:
        widget = Text(
          "好像加载失败了呢？",
          style: TextStyle(color: Colors.black87, fontSize: 16),
        );
        break;
      case IndicatorStatus.empty:
        widget = Text(
          "还没有数据哦~",
          style: TextStyle(color: Colors.black87, fontSize: 16),
        );
        break;
      default:
        widget = Container(height: 0.0);
        break;
    }
    return widget;
  }
}
