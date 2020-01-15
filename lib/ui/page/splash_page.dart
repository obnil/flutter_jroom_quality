import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_jroom_quality/config/resource_mananger.dart';
import 'package:flutter_jroom_quality/config/router_manger.dart';
import 'package:flutter_jroom_quality/generated/i18n.dart';
import 'package:flutter_jroom_quality/view_model/user_model.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  static const List<String> images = <String>[
    'ic_splash_1.png',
    'ic_splash_2.png',
    'ic_splash_3.png',
    'ic_splash_4.png'
  ];

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _countdownController;

  @override
  void initState() {
    _countdownController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _countdownController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<UserModel>(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          Image.asset(
              ImageHelper.wrapAssets(SplashPage
                  .images[new Random().nextInt(SplashPage.images.length)]),
//              colorBlendMode: BlendMode.srcOver,//colorBlendMode方式在android等机器上有些延迟,导致有些闪屏,故采用两套图片的方式
//              color: Colors.black.withOpacity(
//                  Theme.of(context).brightness == Brightness.light ? 0 : 0.65),
              fit: BoxFit.fill),
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  nextPage(context, !model.hasUser);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black.withAlpha(100),
                  ),
                  child: AnimatedCountdown(
                    context: context,
                    goToLogin: !model.hasUser,
                    animation: StepTween(begin: 2, end: 0)
                        .animate(_countdownController),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, this.animation, context, goToLogin})
      : super(key: key, listenable: animation) {
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage(context, goToLogin);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Text(
      (value == 0 ? '' : '$value | ') + S.of(context).splashSkip,
      style: TextStyle(color: Colors.white),
    );
  }
}

void nextPage(context, bool goToLogin) {
  if (goToLogin) {
    Navigator.of(context).pushReplacementNamed(RouteName.login);
  } else {
    Navigator.of(context).pushReplacementNamed(RouteName.tab);
  }
}
