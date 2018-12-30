// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import '../lib/redux/base.dart';
import '../lib/page/app.dart';
import '../lib/common/model/user.dart';
import '../lib/common/util/themeConfig.dart';

void main() {
  testWidgets('test login page to index page', (WidgetTester tester) async {
    Store store;
    await tester.pumpWidget(StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        store = Store<BaseState>(
          appReducer,
          initialState: BaseState(
            userInfo: User(username: ''),
            themeGroup: ThemeConfig.day,
          ),
        );
        return App(store: store);
      },
    ));
    final loginRes = tester.any(find.byKey(Key('登录页面')));
    // 判断现在是否是登录页面
    expect(loginRes, true);
    final submitKey = find.byKey(Key('登录'));
    await tester.enterText(find.byKey(Key('用户名')), 'test');
    await tester.enterText(find.byKey(Key('密码')), '123');
    await tester.tap(submitKey);
    // 插入一秒的帧数
    await tester.pump(
      Duration(seconds: 1),
    );
    // 判断现在是否是首页
    final indexRes = tester.any(find.byKey(Key('首页')));
    expect(indexRes, true);
    expect(store.state.userInfo.username, 'test');
  });
}
