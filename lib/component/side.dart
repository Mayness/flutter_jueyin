import 'package:flutter/material.dart';

class Side extends StatefulWidget {
  @override
  _SideState createState() => _SideState();
}

class _SideState extends State<Side> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Mayness', style: TextStyle(fontSize: 16)),
            accountEmail: Text('1095346833@qq.com', style: TextStyle(fontSize: 16)),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('static/AvatarBg.jpg'),
                fit: BoxFit.fitWidth,
              )
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: ExactAssetImage('static/avatar.jpg'),
            ),
            otherAccountsPictures: <Widget>[
              Icon(Icons.center_focus_weak, size: 30),
              Icon(Icons.account_balance_wallet, size: 30),
            ],
            margin: EdgeInsets.all(0),
          ),
          Flexible(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('个人中心'),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.stars),
                  title: Text('我的关注'),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('文章收藏'),
                  onTap: (){},
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.settings, color: Color(0xFF898989)),
                      onPressed: (){},
                    ),
                    Text('设置'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.brightness_4, color: Color(0xFF898989)),
                      onPressed: (){},
                    ),
                    Text('夜间'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}