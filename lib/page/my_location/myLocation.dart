import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'dart:math';
import '../../common/model/user.dart';

class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  bool switchRes;
  @override
  void initState() {
    super.initState();
    switchRes = true;
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (_, userInfo) {
        return _buildPersonPage(userInfo);
      },
      converter: (Store store) => store.state.userInfo,
    );
  }


  Widget _buildPersonPage(User userInfo) {
    return ListView(
      children: <Widget>[
        _userInfo(userInfo),
        _listCard(),
        _listOption(),
      ],
    );
  }

  Widget _listOption() {
    return Column(
      children: <Widget>[
        _buildTile('消息中心', Icons.message),
        _buildTile('阅读记录', Icons.remove_red_eye),
        _buildTile('标签管理', Icons.label),
        ListTile(
          title: Text('通知', style: Theme.of(context).textTheme.body1),
          leading: Icon(Icons.notifications, color: Theme.of(context).textTheme.body1.color),
          trailing: Switch(
            value: switchRes,
            onChanged: (bool res){
              setState(() {
                switchRes = res;
              });
            },
          ),
        )
      ],
    );
  }
  Widget _buildTile(String name, IconData icon) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(name, style: Theme.of(context).textTheme.body1),
          leading: Icon(icon, color: Theme.of(context).textTheme.body1.color),
          trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).textTheme.body2.color)
        ),
        Divider(),
      ],
    );
  }
  Widget _listCard() {
    List<Map> likeItem = [
      {'title': '点赞数', 'label': '10', 'color': Colors.teal, 'icon': Icons.star},
      {'title': '阅读数', 'label': '80', 'color': Colors.blue, 'icon': Icons.book},
      {'title': '评论数', 'label': '3', 'color': Colors.deepOrange, 'icon': Icons.comment},
    ];
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      height: 100,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 100),
        scrollDirection: Axis.horizontal,
        itemCount: likeItem.length,
        itemBuilder: (_, int index) {
          return Container(
            width: 150,
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight,
                        colors: [
                          likeItem[ index ][ 'color' ][ 800 ],
                          likeItem[ index ][ 'color' ][ 300 ],
                        ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(likeItem[ index ][ 'title' ], style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        )),
                        SizedBox(height: 5),
                        Text(likeItem[ index ][ 'label' ], style: TextStyle(
                          color: Color(0xFFFFFFFF),
                        )),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 8,
                  child: Transform.rotate(
                    angle: - pi / 5,
                    child: Opacity(
                      opacity: .5,
                      child: Icon(likeItem[ index ][ 'icon' ], size: 50),
                    )
                  )
                ),
              ],
            )
          );
        },
      ),
    );
  }
  Widget _userInfo(User userInfo) {
    List<Map> sortList = [
      {'title': '我的文章', 'label': '30'},
      {'title': '我的好友', 'label': '10'},
      {'title': '我的关注', 'label': '5'},
    ];

    final userInfoJson = userInfo.toJson();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              splashColor: Colors.red,
              onPressed: () {},
              icon: Icon(Icons.settings, color: Colors.grey[200]),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: ExactAssetImage('static/avatar.jpg')
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      child: Text(userInfoJson[ 'username' ], style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFFFFFFFF)
                      )),
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Text('1095346833@qq.com', style: TextStyle(
                      color: Color(0x99E8E8E8),
                    ),)
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sortList.map((item) {
                return _sortItem(item[ 'title' ], item[ 'label' ]);
              }).toList(),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      color: Theme.of(context).primaryColor,
    );
  }
  Widget _sortItem(String name, String label) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(name, style: TextStyle(
              color: Color(0x99E8E8E8),
            )),
            Text(label, style: TextStyle(
              color: Color(0xFFFFFFFF),
            )),
          ],
        ),
        InkWell(
          onTap: (){},
          child: Container(
            alignment: Alignment.center,
            height: 25,
            child: name != '我的关注' ? VerticalDivider(color: Color(0xFFE8E8E8), width: 40) : null,
          ),
        )
      ],
    );
  }
}