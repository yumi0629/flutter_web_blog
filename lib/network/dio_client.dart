import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yumi_note/network/api.dart';

typedef SuccessCallback = void Function(dynamic data);

class DioClient {
  const DioClient._();

  static final Dio dio = Dio();

  static void initConfig() {
    dio.options = BaseOptions(baseUrl: Api.baseUrl);
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e) {
        debugPrint('Dio error with request: ${e.request.uri}');
        debugPrint('Request data: ${e.request.data}');
        debugPrint('Dio error: ${e.message}');
        EasyLoading.showError(e.message);
        return e;
      },
    ));
  }

  static _dealDefault(Response resp, SuccessCallback success) {
    if (resp.statusCode == 200) {
      if (resp.data['s'] == 1) {
        success(resp.data['d']);
      } else {
        EasyLoading.showError(resp.data['m'].toString());
      }
    } else {
      EasyLoading.showError(resp.data);
    }
  }

  static get(String url,
      {Map<String, dynamic> queryParameters, SuccessCallback success}) async {
    Response resp = await dio.get(url, queryParameters: queryParameters);
    _dealDefault(resp, success);
  }

  static post(String url,
      {data,
      Map<String, dynamic> queryParameters,
      SuccessCallback success}) async {
    Response resp =
        await dio.post(url, queryParameters: queryParameters, data: data);
    _dealDefault(resp, success);
  }
}
