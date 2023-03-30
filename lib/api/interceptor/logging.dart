import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('--> ${options.method} ${options.uri}');
    debugPrint('header: ${options.headers}');
    debugPrint('Content-Type: ${options.contentType}');
    debugPrint('data: ${options.data}');
    debugPrint('==================================');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('header: ${response.headers.toString()}');
    debugPrint('status code: ${response.statusCode}');
    debugPrint('data: ${response.data}');
    debugPrint('<-- End Http');

    return super.onResponse(response, handler);
  }
}
