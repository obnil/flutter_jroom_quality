import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jroom_quality/config/resource_mananger.dart';
import 'package:flutter_jroom_quality/view_model/theme_model.dart';

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return InkWell(
          onTap: () {
            themeModel.switchRandomTheme();
          },
          child: child,
        );
      },
      child: Hero(
        tag: 'loginLogo',
        child: Image.asset(
          ImageHelper.wrapAssets('ic_login_bg.png'),
          fit: BoxFit.fitWidth,
          color: theme.brightness != Brightness.dark
              ? theme.accentColor
              : Colors.white,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );
  }
}

class LoginFormContainer extends StatelessWidget {
  final Widget child;

  LoginFormContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      /*padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),*/
      /*decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(),
          color: Theme.of(context).cardColor,
          shadows: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(20),
                offset: Offset(1.0, 1.0),
                blurRadius: 10.0,
                spreadRadius: 3.0),
          ]),*/
      child: child,
    );
  }
}


/// LoginPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(4),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}
