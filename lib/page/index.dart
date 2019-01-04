import 'package:flutter/material.dart';
import '../common/util/navigationIconView.dart';
import '../common/util/iconText.dart';
import '../common/util/appBarType.dart';
import '../component/side.dart';

import './home/home.dart';
import './list/listPage.dart';
import './my_location/myLocation.dart';

import '../router/route.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  List<NavigationIconView> _navigationViews;  // 下方导航集合
  List<Widget> _pageList; // 展示页面列表
  int _currentIndex = 0;
  List<IconText> _navigations;
  TextEditingController controller; // 头部输入框控制器
  @override
  void initState() {
    super.initState();
     // 当前展示页下标
    _navigations = [ // 导航图标列表
      IconText('首页', Icons.home, AppBarType.home),
      IconText('列表', Icons.list, AppBarType.list(toSearchPage)),
      IconText('我的', Icons.my_location, AppBarType.myLocation),
    ];
    _navigationViews = _navigations.map((item) => _buildNavigationIcon(item.text, item.icon)).toList();
    _pageList = <Widget> [
      Home(),
      ListPage(),
      MyLocation(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        key: Key('首页'),
        appBar: _navigations[ _currentIndex ].type,
        drawer: _currentIndex == 0 ? Drawer(
          child: Side(),
        ) : null,
        body: Container(
          child: _pageList[ _currentIndex ],
        ),
        bottomNavigationBar: bottomNavigationBar(),
      );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) => view.item).toList(),
      currentIndex: _currentIndex,
      fixedColor: Theme.of(context).textTheme.display1.color,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  NavigationIconView _buildNavigationIcon(String text, IconData icon) {
    return NavigationIconView(
      icon: Icon(icon),
      title: Text(text),
      vsync: this,
    );
  }

  void toSearchPage() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) {
        return AppRoute.getPage('page://search', {});
      },
      transitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      }
    ));
  }
}