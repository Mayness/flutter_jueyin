import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../redux/lib/theme.dart';
import '../common/util/themeConfig.dart';
import '../redux/lib/user.dart';
import '../common/model/user.dart';

class Side extends StatefulWidget {
  @override
  _SideState createState() => _SideState();
}

class _SideState extends State<Side> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector(
        builder: (BuildContext context, store) {
          return _side(store);
        },
        converter: (Store store) => store,
      )
    );
  }
  Widget _side(Store store) {
    final state = store.state;
    return Container(
      decoration: BoxDecoration(
        color: state.themeGroup.type == 'day' ? null : Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(state.userInfo.username, style: TextStyle(fontSize: 16)),
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
            child: Container(
              child: ListView(
                children: [
                  _themeListTile('个人中心', Icons.home),
                  _themeListTile('我的关注', Icons.stars),
                  _themeListTile('我的收藏', Icons.book),
                ],
              ),
            )
          ),
          Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(10, 3, 0, 10),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: (){},
                    ),
                    Text('设置'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: store.state.themeGroup.type == 'day' ? Icon(Icons.brightness_4) : Icon(Icons.brightness_5),
                      onPressed: () => _setTheme(state),
                    ),
                    Text(store.state.themeGroup.type == 'day' ? '夜间' : '日间'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        Navigator.pop(context); // 状态改变 控件需要手动关闭
                        StoreProvider.of(context).dispatch(UserAction(
                          User(username: '')
                        ));
                      },
                    ),
                    Text('注销'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setTheme(state) {
    StoreProvider.of(context).dispatch(ThemeAction(
      state.themeGroup.type == 'day' ? ThemeConfig.dark : ThemeConfig.day
    ));
  }

  Widget _themeListTile(String text, IconData icon, { Function cb }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(text, style: TextStyle(
        color: Theme.of(context).textTheme.body1.color,
      )),
      onTap: cb ?? (){},
    );
  }
}