import 'package:flutter/material.dart';
class AppBarType {
  static final AppBar home = AppBar(
    actions: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 15),
        child: IconButton(
          icon: Icon(Icons.person_add),
          onPressed: () {},
        ),
      )
    ],
  );

  static AppBar list (Function cb) {
    return AppBar(
      title: GestureDetector(
        // 替代子元素的onTap事件
        behavior: HitTestBehavior.translucent,
        onTap: cb,
        child: TextField(
          decoration: InputDecoration(
            enabled: false,
            hintText: '搜索更多...',
            prefixIcon: Icon(Icons.search),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(3.0),
              )
            ),
            filled: true,
            fillColor: Color(0xFFA6D8FF),
          ),
        ),
      )
    );
  }

  static final AppBar myLocation = AppBar(
    title: Text('个人中心'),
  );
}

