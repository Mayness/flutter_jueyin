import 'package:flutter/material.dart';

import '../../common/util/newsTab.dart';
import '../../component/newsList.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  final List<NewsTab> showTabs = [
    NewsTab('头条', NewsList('toutiao')),
    NewsTab('社会', NewsList('shehui')),
    NewsTab('国内', NewsList('guonei')),
    NewsTab('国际', NewsList('guoji')),
    NewsTab('娱乐', NewsList('yule')),
  ];
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: showTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: showTabs.map((NewsTab tab) => Tab(text: tab.text)).toList(),
          ),
        ),
        body: TabBarView(
          children: showTabs.map((NewsTab tab) => tab.newsType).toList(),
        ),
      ),
    );
  }
}