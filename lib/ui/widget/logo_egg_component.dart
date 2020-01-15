import 'package:flutter/material.dart';
import 'package:flutter_jroom_quality/generated/i18n.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_jroom_quality/config/resource_mananger.dart';

class LogoEgg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showToast('蓄势待发,敬请期待');
          },
          child: Image.asset(
            ImageHelper.wrapAssets('ic_splash_logo.png'),
            width: 66,
            height: 69,
          ),
        ),
      ],
    );
  }
}
