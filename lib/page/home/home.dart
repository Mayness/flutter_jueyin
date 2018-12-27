import 'package:flutter/material.dart';
import '../../component/swiper.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../common/util/themeConfig.dart';

import '../../common/util/DetailImage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DetailImage> _collections = [
    DetailImage('本周最热', ExactAssetImage('static/icons/fire.png')),
    DetailImage('收藏集', ExactAssetImage('static/icons/book.png')),
    DetailImage('活动', ExactAssetImage('static/icons/active.png')),
  ];


  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (BuildContext context, theme) {
        return Container(
          child: ListView(
            children: <Widget>[
              SwiperTool(),
              _classfiy(theme),
              _hotList(theme),
            ],
          ),
        );
      },
      converter: (Store store) => store.state.themeGroup,
    );
  }

  Widget _classfiy(ThemeGroup theme) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          theme.otherData.cardShadow,
        ],
        border: Border(bottom: theme.otherData.cardBoard)
      ),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        direction: Axis.horizontal,
        children: _collections.map((item){
          return FlatButton(
            padding: EdgeInsets.all(8),
            onPressed: (){},
              child: Column(
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: item.image,
                        fit: BoxFit.fitHeight
                      ),
                    ),
                  ),
                  Text(item.text, style: TextStyle(
                    color: Theme.of(context).textTheme.body1.color,
                  )),
                ],
              ),
            );
          }).toList(),
        ),
    );
  }

  Widget _hotList(ThemeGroup theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          theme.otherData.cardShadow,
        ],
        border: Border(bottom: theme.otherData.cardBoard)
      ),
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(bottom: BorderSide(color: Color(0x88CCCCCC), width: 1, style: BorderStyle.solid))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'static/icons/fire.png',
                    width: 25,
                    height: 25
                  )
                ),
                Text('热门文章')
              ],
            ),
          ),
          Column(
            children: <Widget>[
              _listItem('Vue.js 组件精讲', 'Aresn', 'static/vue.png'),
              _listItem('React实战：设计模式和最佳实践', '程墨', 'static/react.png'),
              _listItem('停止学习框架', 'auth'),
              _listItem('驳《停止学习框架》', 'auth2'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listItem(String title, String auth, [ String imageUri ]) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(color: Color(0x88CCCCCC), width: 1, style: BorderStyle.solid))
      ),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: TextStyle(fontSize: 16, height: .8, color: Theme.of(context).textTheme.body1.color)),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(auth, style: TextStyle(color: Theme.of(context).textTheme.body2.color))
                  ),
                  Text(DateTime.now().toString().substring(0, 16), style: TextStyle(color: Theme.of(context).textTheme.body2.color)),
                ],
              ),
            ),
          ),
          imageUri != null ? Container(
            margin: EdgeInsets.only(left: 40),
            child: Image.asset(imageUri, width: 50, height: 50),
          ) : SizedBox(),
        ],
      ),
    );

  }
}