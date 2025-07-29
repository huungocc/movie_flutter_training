import 'package:dio/dio.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtil {
  static Dio? _dio;
  static ApiClient? _apiClient;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options.baseUrl = MovieAPIConfig.baseUrl;
      _dio!.options.connectTimeout = const Duration(milliseconds: 30000);
      _dio!.options.receiveTimeout = const Duration(milliseconds: 30000);

      // Thêm interceptors
      _dio!.interceptors.add(ApiInterceptors());
      _dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: false,
      ));
    }
    return _dio!;
  }

  static ApiClient get apiClient {
    _apiClient ??= ApiClient(getDio(), baseUrl: MovieAPIConfig.baseUrl);
    return _apiClient!;
  }

  // Reset dio instance nếu cần
  static void resetDio() {
    _dio = null;
    _apiClient = null;
  }
}