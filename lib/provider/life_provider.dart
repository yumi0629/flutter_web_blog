import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:yumi_note/model/life.dart';
import 'package:yumi_note/network/api.dart';
import 'package:yumi_note/network/dio_client.dart';

class LifeListProvider with ChangeNotifier {
  final _LifeListRepository listRepository = _LifeListRepository();

  LifeListProvider() {
    listRepository.attach(this);
  }

  void loadSuccess() {
    debugPrint('loadSuccess');
    notifyListeners();
  }
}

class _LifeListRepository extends LoadingMoreBase<Life> {
  void attach(LifeListProvider provider) {
    this.provider = provider;
  }

  LifeListProvider provider;

  int pageIndex = 1;
  bool _hasMore = true;

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    pageIndex = 1;
    var result = await super.refresh(clearBeforeRequest);
    return result;
  }

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    bool isSuccess = false;
    try {
      await DioClient.get(Api.lifeList, success: (data) {
        var source = getLifeList(data);
        if (pageIndex == 1) {
          this.clear();
        }
        this.addAll(source);
//        _hasMore = source.length != 0;
        _hasMore = false;
        pageIndex++;
        isSuccess = true;
      });
    } catch (exception, stack) {
      isSuccess = false;
      debugPrint(exception);
      print(stack);
    }
    debugPrint('loadData $isSuccess');
    if (isSuccess) provider.loadSuccess();
    return isSuccess;
  }
}

class LifeDetailProvider with ChangeNotifier {
  final int postId;
  Life life;

  LifeDetailProvider(this.postId) {
    if (life == null) getLifeDetail();
  }

  void getLifeDetail() {
    DioClient.get('${Api.lifeDetail}$postId', success: (data) {
      life = Life.fromJson(data);
      notifyListeners();
    });
  }
}
