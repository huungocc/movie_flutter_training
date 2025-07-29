import 'package:dio/dio.dart';
import 'package:movie_flutter_training/utils/exception_handler.dart';
import 'package:movie_flutter_training/utils/logger.dart';

class ApiInterceptors extends QueuedInterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i("✅ SUCCESS[${response.statusCode}] => PATH: ${response.requestOptions.path}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;

    logger.e("⚠️ ERROR[$statusCode] => PATH: $path\nResponse: ${err.response?.data}");

    final errorMessage = ExceptionHandler.handleDioError(err);

    ExceptionHandler.showErrorSnackBar(errorMessage);

    handler.next(err);
  }
}
