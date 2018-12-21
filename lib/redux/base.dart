import '../common/model/user.dart';
import 'package:flutter/material.dart';
import './lib/user.dart';
import './lib/theme.dart';

class BaseState {
  User userInfo;
  ThemeData themeData;

  BaseState({ this.userInfo, this.themeData });
}

BaseState appReducer(BaseState state, action) {
  return BaseState(
    userInfo: UsernameReducer(state.userInfo, action),
    themeData: ThemeReducer(state.themeData, action),
  );
}