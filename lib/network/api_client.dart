import 'package:dio/dio.dart';
import 'package:movie_flutter_training/models/response/array_response.dart';
import 'package:retrofit/retrofit.dart';

import '../models/entities/movie/movie_entity.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  /// Movie APIs
  @GET("/3/movie/popular")
  Future<ArrayResponse<MovieEntity>> getPopularMovies(
      @Query('api_key') String apiKey,
      @Query('page') int page,
      );

  @GET("/3/movie/{id}")
  Future<MovieEntity> getDetailMovie(
      @Query('api_key') String apiKey,
      @Path('id') int id,
      );
}
