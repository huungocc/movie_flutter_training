import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';
import 'package:movie_flutter_training/network/api_client.dart';
import 'package:movie_flutter_training/network/api_interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class ApiUtil {
  @lazySingleton
  Dio dio() {
    final dio = Dio();
    dio.options.baseUrl = MovieAPIConfig.baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 30000);
    dio.options.receiveTimeout = const Duration(milliseconds: 30000);

    // Add interceptors
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      compact: false,
    ));

    return dio;
  }

  @lazySingleton
  ApiClient apiClient(Dio dio) =>
      ApiClient(dio, baseUrl: MovieAPIConfig.baseUrl);
}
