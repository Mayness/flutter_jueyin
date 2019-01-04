import 'package:redux/redux.dart';
import '../../common/util/themeConfig.dart';

// 主题信息存储
final ThemeReducer = combineReducers<ThemeGroup>([
  TypedReducer<ThemeGroup, ThemeAction>(_updateThemeData)
]);

ThemeGroup _updateThemeData(ThemeGroup themeGroup, action) {
  themeGroup = action.themeGroup;
  return themeGroup;
}

class ThemeAction {
  ThemeGroup themeGroup;
  ThemeAction(this.themeGroup);
}