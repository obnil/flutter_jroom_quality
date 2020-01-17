import 'package:flutter_jroom_quality/config/net/base_api.dart';
import 'package:flutter_jroom_quality/model/app_model.dart';
import 'package:flutter_jroom_quality/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class BaseRepository {

  static Future<AppUpdateInfo> checkUpdate(String platform, String version) async {
    debugPrint('检查更新,当前版本为===>$version');
    var response = await http.post('app/check', queryParameters: {
      'buildVersion': version
    });
    var result = AppUpdateInfo.fromMap(response.data);
    if(result.buildHaveNewVersion){
      debugPrint('发现新版本===>${result.buildVersion}');
      return result;
    }
    debugPrint('没有发现新版本');
    return null;
  }

  /// 登录
  /// [Http._init] 添加了拦截器 设置了自动cookie.
  static Future login(String username, String password) async {
    var response = await http.post('scmapp/login', data: {
      'userName': username,
      'password': password,
      'appId': 'scmapp',
    });
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = username;
    data['password'] = password;
    data['token'] = response.data;
    data['username'] = username;
    return User.fromJsonMap(data);
  }

  /// 登出
  static logout() async {
    /// 自动移除cookie
    await http.get('user/logout/json');
  }
}
