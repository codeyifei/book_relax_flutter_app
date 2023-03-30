import 'package:book_relax_flutter_app/entity/mixin.dart';
import 'package:book_relax_flutter_app/entity/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class LoginRequest with ToJsonMixin {
  String username;
  String password;

  LoginRequest(this.username, this.password);

  factory LoginRequest.fromJson(JsonData json) => _$LoginRequestFromJson(json);

  @override
  JsonData toJson() => _$LoginRequestToJson(this);

  @override
  String toString() {
    return 'LoginRequest{username: $username, password: $password}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse with ToJsonMixin {
  int userId;
  String nickname;
  String accessToken;
  String refreshToken;
  DateTime expiration;

  LoginResponse(
    this.userId,
    this.nickname,
    this.accessToken,
    this.refreshToken,
    this.expiration,
  );

  factory LoginResponse.fromJson(JsonData json) => _$LoginResponseFromJson(json);

  @override
  JsonData toJson() => _$LoginResponseToJson(this);

  @override
  String toString() {
    return 'LoginResponse{userId: $userId, nickname: $nickname, accessToken: $accessToken, refreshToken: $refreshToken, expiration: $expiration}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthUserResponse with ToJsonMixin {
  int id;
  String username;
  String nickname;
  DateTime lastLoginTime;

  AuthUserResponse(this.id, this.username, this.nickname, this.lastLoginTime);

  factory AuthUserResponse.fromJson(JsonData json) => _$AuthUserResponseFromJson(json);

  @override
  JsonData toJson() => _$AuthUserResponseToJson(this);

  @override
  String toString() {
    return 'AuthUserResponse{id: $id, username: $username, nickname: $nickname, lastLoginTime: $lastLoginTime}';
  }
}

@JsonSerializable()
class RegisterRequest with ToJsonMixin {
  String username;
  String password;
  String nickname;

  RegisterRequest(this.username, this.password, this.nickname);

  factory RegisterRequest.fromJson(JsonData json) => _$RegisterRequestFromJson(json);

  @override
  JsonData toJson() => _$RegisterRequestToJson(this);

  @override
  String toString() {
    return 'RegisterRequest{username: $username, password: $password, nickname: $nickname}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterResponse with ToJsonMixin {
  int id;
  String username;
  String nickname;
  DateTime registerTime;

  RegisterResponse(this.id, this.username, this.nickname, this.registerTime);

  factory RegisterResponse.fromJson(JsonData json) => _$RegisterResponseFromJson(json);

  @override
  JsonData toJson() => _$RegisterResponseToJson(this);

  @override
  String toString() {
    return 'RegisterResponse{id: $id, username: $username, nickname: $nickname, registerTime: $registerTime}';
  }
}
