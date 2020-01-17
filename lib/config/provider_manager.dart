import 'package:flutter_jroom_quality/view_model/locale_view_model.dart';
import 'package:flutter_jroom_quality/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jroom_quality/view_model/theme_view_model.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<LocaleModel>(
    create: (context) => LocaleModel(),
  ),
  ChangeNotifierProvider<UserModel>(
    create: (context) => UserModel(),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
