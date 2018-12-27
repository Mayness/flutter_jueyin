import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import './page/app.dart';
import './common/model/user.dart';
import './redux/base.dart';
import './common/util/themeConfig.dart';

void main() {
  // debugPaintSizeEnabled = true;
  final store = Store<BaseState>(
    appReducer,
    initialState: BaseState(
      userInfo: User(username: ''),
      themeGroup: ThemeConfig.day,
    ),
  );
  runApp(App(store: store));
}