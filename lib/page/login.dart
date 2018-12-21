import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../common/model/user.dart';

import '../redux/lib/user.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String _username;
  String _passwd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        actions: <Widget>[
          Container(
            child: InkWell(
              child: Text('忘记密码？',
                style: TextStyle(
                  fontSize: 16,
                )
              )
            ),
            alignment: Alignment.center,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('static/loginBg.jpeg'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              )
            ),
          ),
          // flexible+ListView组合防止输入框弹起后超出手机
          Flexible(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: _form(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: _getTextFormField(),
      ),
    );
  }
  List<Widget> _getTextFormField() {
    final List<Widget> textGroup = [];
    final List<String> params = [ '用户名', '密码' ];
    final formField = params.map((item) {
      return TextFormField(
        validator: (value) => value == '' ? '请输入您的$item' : null,
        onSaved: (val) => item == '用户名' ? _username = val : _passwd = val,
        decoration: InputDecoration(
          hintText: '请输入您的$item',
          labelText: item,
        ),
        obscureText: item == '密码' ? true : false,
      );
    });
    textGroup.addAll(
      formField.toList(),
    );
    textGroup.add(
      Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getButton('注册账号', () => {}),
            _getButton('登录', _submit),
          ],
        ),
      )
    );
    return textGroup;
  }

  // 提交表单
  _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      StoreProvider.of(context).dispatch(UpdateUserAction(
        User(username: _username)
      ));
    }
  }

  // 按钮样式
  Widget _getButton(String type, cb) {
    Color mainColor = type == '注册账号' ? Colors.blue : Colors.white;
    Color subColor = type == '注册账号' ? Colors.white : Colors.blue;
    return RaisedButton(
      onPressed: cb,
      child: Container(
        child: Text(type),
        alignment: Alignment.center,
        height: 45,
        width: 80,
      ),
      color: subColor,
      shape: Border.all(color: mainColor),
      textColor: mainColor,
      elevation: 0,
      highlightElevation: 0,
    );
  }
}