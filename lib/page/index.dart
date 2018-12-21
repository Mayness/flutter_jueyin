import 'package:flutter/material.dart';
import '../common/util/navigation_icon_view.dart';
import '../component/side.dart';

import './home/home.dart';
import './list/listPage.dart';
import './my_location/myLocation.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  List<NavigationIconView> _navigationViews;  // 下方导航集合
  List<Widget> _pageList; // 页面列表
  Widget _currentPage;  // 当前展示页
  int _currentIndex = 0; // 当前展示页下标

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView> [
      NavigationIconView(
        icon: Icon(Icons.home),
        title: Text('首页'),
        vsync: this,
      ),
      NavigationIconView(
        icon: Icon(Icons.list),
        title: Text('列表'),
        vsync: this,
      ),
      NavigationIconView(
        icon: Icon(Icons.my_location),
        title: Text('我的'),
        vsync: this,
      ),
    ];
    _pageList = <Widget> [
      Home(),
      ListPage(),
      MyLocation(),
    ];
    _currentPage = _pageList[ _currentIndex ];
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
        appBar: AppBar(
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15),
              child: IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () => {},
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: Side(),
        ),
        body: Container(
          child: _currentPage,
        ),
        bottomNavigationBar: bottomNavigationBar(),
      );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) => view.item).toList(),
      currentIndex: _currentIndex,
      fixedColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          _currentPage = _pageList[ _currentIndex ];
        });
      },
    );
  }

  
}