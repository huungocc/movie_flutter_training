import 'package:flutter/material.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/utils/exception_handler.dart';

class ListMovieProvider extends ChangeNotifier {
  final MovieRepositoryImpl movieRepository;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool isComplete = false;
  bool isRefreshing = false;

  int _currentPage = 1;
  int _totalPages = 1;

  final List<MovieEntity> _movies = [];
  List<MovieEntity> get movies => _movies;

  ListMovieProvider(this.movieRepository);

  Future<void> fetchPopularMovies({bool refresh = false}) async {
    if (refresh) {
      _movies.clear();
      _currentPage = 1;
      isComplete = false;
      isRefreshing = true;
    } else {
      isLoading = true;
    }

    notifyListeners();

    try {
      final response = await movieRepository.getPopularMovies(page: 1);
      _movies
        ..clear()
        ..addAll(response.results);
      _currentPage = response.page;
      _totalPages = response.totalPages;

      isComplete = _currentPage >= _totalPages;
    } catch (e) {
      ExceptionHandler.handleError(e);
    } finally {
      if (refresh) {
        isRefreshing = false;
      } else {
        isLoading = false;
      }
      notifyListeners();
    }
  }

  Future<void> loadMoreMovies() async {
    if (isLoadingMore || isComplete) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      final nextPage = _currentPage + 1;
      final response = await movieRepository.getPopularMovies(page: nextPage);
      _movies.addAll(response.results);
      _currentPage = response.page;
      _totalPages = response.totalPages;

      isComplete = _currentPage >= _totalPages;
    } catch (e) {
      ExceptionHandler.handleError(e);
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }
}

