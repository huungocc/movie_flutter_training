import 'package:flutter/material.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/utils/exception_handler.dart';

class DetailMovieProvider extends ChangeNotifier {
  final MovieRepositoryImpl movieRepository;

  bool isLoading = false;

  MovieEntity? movieEntity;

  DetailMovieProvider(this.movieRepository) {
    print("Hungdq 1");
  }


  Future<void> loadSingleMovie(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      movieEntity = await movieRepository.getDetailMovie(id: id);
    } catch (e) {
      ExceptionHandler.handleError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
