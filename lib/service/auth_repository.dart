import 'package:flutter_jroom_quality/config/net/auth_api.dart';
import 'package:flutter_jroom_quality/model/permission_model.dart';

class AuthRepository {

  /// 登录
  /// [Http._init] 添加了拦截器 设置了自动cookie.
  static Future requestPermission() async {
    var response = await http.post<Map>('auth/user/me', queryParameters: {
    });
    return PermissionDetail.fromJsonMap(response.data);
  }
}
