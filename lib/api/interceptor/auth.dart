import 'dart:io';

import 'package:book_relax_flutter_app/state/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthInterceptor extends Interceptor {
  final List<String> noAuthPath = [
    '/auth/login:POST'
  ];

  AuthState get _authState => Get.find();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var sign = '${options.path}:${options.method.toUpperCase()}';
    if (!noAuthPath.contains(sign) && _authState.isLoggedIn) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${_authState.accessToken}';
    }

    super.onRequest(options, handler);
  }
}
