import 'dart:async';

import 'package:book_relax_flutter_app/api/http.dart';
import 'package:book_relax_flutter_app/entity/vo/auth.dart';

class AuthClient {
  static Future<LoginResponse> login(String username, String password) async {
    var resp = await HttpClient().post(
      '/auth/login',
      data: LoginRequest(username, password),
    );

    return LoginResponse.fromJson(resp.data);
  }

  static Future<AuthUserResponse> user() async {
    var resp = await HttpClient().get('/auth/user');

    return AuthUserResponse.fromJson(resp.data);
  }

  static Future<void> logout() async {
    await HttpClient().post('/auth/logout');
  }
}
