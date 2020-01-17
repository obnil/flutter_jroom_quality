import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jroom_quality/generated/i18n.dart';
import 'package:flutter_jroom_quality/ui/page/tab/business_page.dart';
import 'package:flutter_jroom_quality/ui/page/tab/home_page.dart';
import 'package:flutter_jroom_quality/ui/page/tab/mine_page.dart';
import 'package:flutter_jroom_quality/ui/widget/app_update.dart';

List<Widget> pages = <Widget>[
  BusinessPage(),
  HomePage(),
  MinePage()
];

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text(S.of(context).tabBusiness),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(S.of(context).tabHome),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            title: Text(S.of(context).tabUser),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  @override
  void initState() {
    checkAppUpdate(context);
    requestPermission(context);
    super.initState();
  }
}
