// flutter packages pub run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String username;

  User({ this.username });

  factory User.fromJson(json) => _$UserFromJson(json);
  toJson() => _$UserToJson(this);

  User.empty();
}