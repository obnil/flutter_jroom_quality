import 'package:flutter/cupertino.dart';
import 'package:flutter_jroom_quality/config/storage_manager.dart';
import 'package:flutter_jroom_quality/model/permission_model.dart';
import 'package:flutter_jroom_quality/provider/view_state_model.dart';
import 'package:flutter_jroom_quality/service/auth_repository.dart';
import 'package:flutter_jroom_quality/service/base_repository.dart';

const String kLoginName = 'kLoginName';

class PermissionModel extends ChangeNotifier {
  Future requestPermission(BuildContext context) async {
    AuthRepository.requestPermission();
  }
}
