import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import './page/app.dart';
import './common/model/user.dart';
import './redux/base.dart';

// import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  final store = Store<BaseState>(
    appReducer,
    initialState: BaseState(
      userInfo: User(username: ''),
      themeData: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],
        // accentColor: Colors.cyan[600],
      )
    ),
  );
  runApp(App(store: store));
}