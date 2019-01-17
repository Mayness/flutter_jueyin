import 'package:redux/redux.dart';
import '../../common/model/user.dart';

// 用户信息存储
final UsernameReducer = combineReducers<User>([
  TypedReducer<User, UserAction>(_updateUser),
]);

User _updateUser(User user, action) {
  user = action.username;
  return user;
}

class UserAction {
  User username;
  UserAction(this.username);
}