import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// 用户信息存储
final ThemeReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, ThemeAction>(_updateThemeData)
]);

ThemeData _updateThemeData(ThemeData themeData, action) {
  themeData = action.themeData;
  return themeData;
}

class ThemeAction {
  ThemeData themeData;
  ThemeAction(this.themeData);
}