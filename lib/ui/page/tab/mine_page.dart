import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_jroom_quality/generated/i18n.dart';
import 'package:flutter_jroom_quality/ui/widget/app_bar.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jroom_quality/config/resource_mananger.dart';
import 'package:flutter_jroom_quality/config/router_manger.dart';
import 'package:flutter_jroom_quality/provider/provider_widget.dart';
import 'package:flutter_jroom_quality/view_model/login_view_model.dart';
import 'package:flutter_jroom_quality/view_model/theme_view_model.dart';
import 'package:flutter_jroom_quality/view_model/user_view_model.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[
            ProviderWidget<LoginModel>(
                model: LoginModel(Provider.of(context)),
                builder: (context, model, child) {
                  if (model.busy) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: AppBarIndicator(),
                    );
                  }
                  if (model.userModel.hasUser) {
                    return IconButton(
                      tooltip: S.of(context).logout,
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        model.logout();
                      },
                    );
                  }
                  return SizedBox.shrink();
                })
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: 200 + MediaQuery.of(context).padding.top,
          flexibleSpace: UserHeaderWidget(),
          pinned: false,
        ),
        UserListWidget(),
      ],
    ));
  }
}

class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        child: Container(
            color: Theme.of(context).primaryColor.withAlpha(200),
            padding: EdgeInsets.only(top: 10),
            child: Consumer<UserModel>(
                builder: (context, model, child) => InkWell(
                    onTap: model.hasUser
                        ? null
                        : () {
                            Navigator.of(context).pushNamed(RouteName.login);
                          },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Hero(
                              tag: 'loginLogo',
                              child: ClipOval(
                                child: Image.asset(
                                    ImageHelper.wrapAssets('ic_user_avatar.png'),
                                    fit: BoxFit.cover,
                                    width: 38,
                                    height: 38,
                                    color: model.hasUser
                                        ? Theme.of(context)
                                            .accentColor
                                            .withAlpha(200)
                                        : Theme.of(context)
                                            .accentColor
                                            .withAlpha(10),
                                    // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                                    colorBlendMode: BlendMode.colorDodge),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(children: <Widget>[
                            Text(
                                model.hasUser
                                    ? model.user.username
                                    : S.of(context).toSignIn,
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .apply(color: Colors.white.withAlpha(200))),
                            SizedBox(
                              height: 10,
                            ),
                          ])
                        ])))));
  }
}

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliverList(
        delegate: SliverChildListDelegate([
          ListTile(
            title: Text(S.of(context).favourites),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.favouriteList);
            },
            leading: Icon(
              Icons.favorite_border,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(S.of(context).darkMode),
            onTap: () {
              switchDarkMode(context);
            },
            leading: Transform.rotate(
              angle: -pi,
              child: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.brightness_5
                    : Icons.brightness_2,
                color: iconColor,
              ),
            ),
            trailing: CupertinoSwitch(
                activeColor: Theme.of(context).accentColor,
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  switchDarkMode(context);
                }),
          ),
          SettingThemeWidget(),
          ListTile(
            title: Text(S.of(context).setting),
            onTap: () {
              Navigator.pushNamed(context, RouteName.setting);
            },
            leading: Icon(
              Icons.settings,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(S.of(context).appUpdateCheckUpdate),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.login);
            },
            leading: Icon(
              Icons.system_update,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }

  void switchDarkMode(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      showToast("检测到系统为暗黑模式,已为你自动切换", position: ToastPosition.bottom);
    } else {
      Provider.of<ThemeModel>(context).switchTheme(
          userDarkMode: Theme.of(context).brightness == Brightness.light);
    }
  }
}

class SettingThemeWidget extends StatelessWidget {
  SettingThemeWidget();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(S.of(context).theme),
      leading: Icon(
        Icons.color_lens,
        color: Theme.of(context).accentColor,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[
              ...Colors.primaries.map((color) {
                return Material(
                  color: color,
                  child: InkWell(
                    onTap: () {
                      var model = Provider.of<ThemeModel>(context);
                      var brightness = Theme.of(context).brightness;
                      model.switchTheme(color: color);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                );
              }).toList(),
              Material(
                child: InkWell(
                  onTap: () {
                    var model = Provider.of<ThemeModel>(context);
                    var brightness = Theme.of(context).brightness;
                    model.switchRandomTheme(brightness: brightness);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).accentColor)),
                    width: 40,
                    height: 40,
                    child: Text(
                      "?",
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
