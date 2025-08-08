import 'package:injectable/injectable.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/models/response/array_response.dart';
import 'package:movie_flutter_training/network/api_client.dart';

abstract class MovieRepository {
  Future<ArrayResponse<MovieEntity>> getPopularMovies({required int page});

  Future<MovieEntity?> getDetailMovie({required int id});
}

@Injectable(as: MovieRepository)
class MovieRepositoryImpl extends MovieRepository {
  ApiClient apiClient;

  MovieRepositoryImpl({required this.apiClient});

  @override
  Future<MovieEntity?> getDetailMovie({required int id}) {
    return apiClient.getDetailMovie(MovieAPIConfig.apiKey, id);
  }

  @override
  Future<ArrayResponse<MovieEntity>> getPopularMovies({required int page}) async {
    return apiClient.getPopularMovies(MovieAPIConfig.apiKey, page);
  }
}

