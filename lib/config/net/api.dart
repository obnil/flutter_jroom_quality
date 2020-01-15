import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jroom_quality/utils/platform_utils.dart';

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    String proxy = "192.168.1.241:8888";
    /// 初始化 加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY $proxy";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    interceptors..add(HeaderInterceptor());
    init();
  }

  void init();
}

/// 添加常用Header
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 1000 * 45;
    options.receiveTimeout = 1000 * 45;

    var appVersion = await PlatformUtils.getAppVersion();
    var version = Map()
      ..addAll({
        'appVerison': appVersion,
      });
    options.headers['version'] = version;
    options.headers['platform'] = Platform.operatingSystem;
    return options;
  }
}

/// 子类需要重写
abstract class BaseResponseData {
  int code = 0;
  String msg;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.msg, this.data});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $msg, data: $data}';
  }
}


/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String msg;

  NotSuccessException.fromRespData(BaseResponseData respData) {
    msg = respData.msg;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $msg}';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}

