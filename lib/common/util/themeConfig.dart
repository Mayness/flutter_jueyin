import 'package:flutter/material.dart';
class ThemeConfig {
  static final ThemeGroup day = ThemeGroup(
    type: 'day',
    themeData: ThemeData(
      accentColor: Colors.blue,  //  控件下方选择颜色、loading颜色
      indicatorColor: Colors.white, // 控件下方的选择颜色
      cardColor: Colors.white,  // 卡片背景色
      scaffoldBackgroundColor: Color(0xFFF3F3F3), // 背景颜色
      primaryColor: Colors.blue,  // 顶部栏
      primaryIconTheme: IconThemeData(
        color: Colors.black,  // 顶部图标颜色
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white, // 导航栏文字的颜色
        unselectedLabelColor: Colors.white, // 导航没有选中文字的颜色
      ),
      textTheme: TextTheme(
        body1: TextStyle(
          color: Colors.black,  // 常规文字的颜色
        ),
        body2: TextStyle(
          color: Colors.black38,  // 注解文字的颜色
        ),
        display1: TextStyle(
          color: Colors.blue,   // 底部导航栏高亮颜色
        ),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF898989),
      ),
      dividerColor: Color(0x33000000),
      // highlightColor: Colors.red, // 点击高亮的颜色
      // splashColor: Colors.red,  // 点击墨水动画的颜色
    ),
    otherData: OtherData(
      cardShadow: BoxShadow(offset: Offset(0, 1), color: Color(0xFFCCCCCC)),
      cardBoard: BorderSide(color: Color(0xFFCCCCCC), width: .1, style: BorderStyle.solid),
    ), // 其他配置的颜色
  );

  static final ThemeGroup dark = ThemeGroup(
    type: 'dark',
    themeData: ThemeData(
      canvasColor: Color(0xFF666666),  // 底部导航栏背景颜色
      accentColor: Color(0xFFCCCCCC),
      indicatorColor:  Color(0xFFCCCCCC),
      cardColor: Color(0xFF3F3f3F),
      scaffoldBackgroundColor: Color(0xFF333333),
      primaryColor: Color(0xFF3f3F3F),
      primaryIconTheme: IconThemeData(
        color: Color(0xFFCCCCCC),
      ),
      textTheme: TextTheme(
        body1: TextStyle(
          color: Color(0xFFE8E8E8),
        ),
        body2: TextStyle(
          color: Color(0x99E8E8E8),
        ),
        display1: TextStyle(
          color: Color(0xFFE8E8E8),
        ),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFFE8E8E8),
      ),
      dividerColor: Color(0x33E8E8E8),
    ),
    otherData: OtherData(
      cardShadow: BoxShadow(offset: Offset(0, 1), color: Color(0x223f3f3f)),
      cardBoard: BorderSide(color: Color(0xFF3f3f3f), width: .1, style: BorderStyle.solid),
    ),
  );
}

class ThemeGroup {
  String type;
  ThemeData themeData;
  OtherData otherData;
  ThemeGroup({this.type, this.themeData, this.otherData });
}

class OtherData {
  Color mainBackgroundColor;  // 背景颜色主色
  Color mainFontColor;  // 文字主色
  BoxShadow cardShadow;  // 卡片shadow样式
  BorderSide cardBoard;  // 卡片边框样式
  OtherData({
    this.mainBackgroundColor,
    this.mainFontColor,
    this.cardShadow,
    this.cardBoard,
  });
}