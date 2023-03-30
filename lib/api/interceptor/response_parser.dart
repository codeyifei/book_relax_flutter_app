import 'package:dio/dio.dart';

class ResponseParserInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200 && response.data['code'] == 0) {
      response.data = response.data['data'];
      return super.onResponse(response, handler);
    }

    var dioError = DioError(
      requestOptions: response.requestOptions,
      type: DioErrorType.badResponse,
      response: response,
    );
    handler.reject(dioError);
  }
}
