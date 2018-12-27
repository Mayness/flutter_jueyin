import '../common/model/user.dart';
// import 'package:flutter/material.dart';
import './lib/user.dart';
import './lib/theme.dart';
import '../common/util/themeConfig.dart';

class BaseState {
  User userInfo;
  ThemeGroup themeGroup;

  BaseState({ this.userInfo, this.themeGroup });
}

BaseState appReducer(BaseState state, action) {
  return BaseState(
    userInfo: UsernameReducer(state.userInfo, action),
    themeGroup: ThemeReducer(state.themeGroup, action),
  );
}