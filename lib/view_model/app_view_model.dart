import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_jroom_quality/model/app_model.dart';
import 'package:flutter_jroom_quality/provider/view_state_model.dart';
import 'package:flutter_jroom_quality/service/base_repository.dart';
import 'package:flutter_jroom_quality/utils/platform_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAppFirstEntry = 'kAppFirstEntry';

// 主要用于app启动相关
class AppModel with ChangeNotifier {
  bool isFirst = false;

  loadIsFirstEntry() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isFirst = sharedPreferences.getBool(kAppFirstEntry);
    notifyListeners();
  }
}

class AppUpdateModel extends ViewStateModel {
  Future<AppUpdateInfo> checkUpdate() async {
    AppUpdateInfo appUpdateInfo;
    setBusy();
    try {
      var appVersion = await PlatformUtils.getAppVersion();
      appUpdateInfo =
          await BaseRepository.checkUpdate(Platform.operatingSystem, appVersion);
      setIdle();
    } catch (e, s) {
      setError(e,s);
    }
    return appUpdateInfo;
  }
}
