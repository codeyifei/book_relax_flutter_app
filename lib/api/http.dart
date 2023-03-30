import 'dart:async';
import 'dart:io';

import 'package:book_relax_flutter_app/api/interceptor/auth.dart';
import 'package:book_relax_flutter_app/api/interceptor/logging.dart';
import 'package:book_relax_flutter_app/api/interceptor/response_parser.dart';
import 'package:book_relax_flutter_app/component/dialog.dart';
import 'package:book_relax_flutter_app/state/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart' as getx;

class HttpClient {
  static final HttpClient _instance = HttpClient._();

  factory HttpClient() => _instance;

  AuthState get authState => getx.Get.find();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: FlutterConfig.get('BASE_URL'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    ),
  );

  HttpClient._() {
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(ResponseParserInterceptor());
  }

  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (error) {
      return handingDioRequest(error);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (error) {
      return handingDioRequest(error);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (error) {
      return handingDioRequest(error);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioError catch (error) {
      return handingDioRequest(error);
    }
  }

  Future<Response> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    return _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }

  Future<Response<T>> handingDioRequest<T>(DioError error) {
    if (error.type == DioErrorType.badResponse &&
        error.response!.statusCode == 200) {
      var code = error.response!.data['code'];
      switch (code) {
        case 400:
          var message = error.response!.data['message'] ?? '参数错误';
          CustomerDialog(message, type: DialogType.error).show();
          break;
        case 401:
          getx.Get.snackbar('提示', '请先登录');
          authState.toLogin();
          break;
      }
    }
    throw error;
  }
}

class RequestError implements Exception {
  final int _code;
  final String _message;

  RequestError(this._code, this._message);

  static final Map<int, String> _responseMessageMap = {
    400: '参数错误',
    401: '未登录',
    403: '无操作权限',
    404: '资源未找到',
    405: '请求方法不被允许',
    500: '服务器内部错误',
  };

  factory RequestError.create(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return RequestError(-1, '请求取消');
      case DioErrorType.connectionTimeout:
        return RequestError(-1, '连接超时');
      case DioErrorType.sendTimeout:
        return RequestError(-1, '请求超时');
      case DioErrorType.receiveTimeout:
        return RequestError(-1, '响应超时');
      case DioErrorType.badCertificate:
        return RequestError(-1, '证书错误');
      case DioErrorType.connectionError:
        return RequestError(-1, '连接错误');
      case DioErrorType.unknown:
        return RequestError(-1, '未知错误');
      case DioErrorType.badResponse:
        var statusCode = error.response!.statusCode!;
        if (statusCode != 200) {
          return RequestError(
              statusCode,
              _responseMessageMap[statusCode] ??
                  error.response!.statusMessage!);
        }

        var code = error.response!.data['code'];
        if (code == null) return RequestError(-1, '未知错误');

        switch (code) {
          // case
          default:
            return RequestError(
                code, error.response!.data['message'] ?? '未知错误');
        }
      default:
        return RequestError(-1, error.response!.statusMessage!);
    }
  }

  String get message => _message;

  @override
  String toString() {
    return 'http request error! [$_code] $_message';
  }
}
