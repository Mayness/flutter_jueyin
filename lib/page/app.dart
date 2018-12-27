import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import './login.dart';
import './index.dart';

class App extends StatelessWidget{
  App({ this.store });
  final store;
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: StoreConnector(
          builder: (BuildContext context, store) {
            return MaterialApp(
              title: '倔银',
              theme: store.state.themeGroup.themeData,
              home: store.state.userInfo.username == '' ? LoginPage() : IndexPage(),
            );
          },
          converter: (Store store) => store,
        ),
    );
  }
}