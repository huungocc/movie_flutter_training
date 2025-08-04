import 'package:flutter/material.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/utils/exception_handler.dart';

enum MovieLoadingState {
  initial,
  loading,
  loaded,
  error,
  refreshing,
  loadingMore,
}

class ListMovieProvider extends ChangeNotifier {
  final MovieRepositoryImpl movieRepository;

  MovieLoadingState _state = MovieLoadingState.initial;
  MovieLoadingState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int _totalPages = 1;

  final List<MovieEntity> _movies = [];
  List<MovieEntity> get movies => _movies;

  ListMovieProvider(this.movieRepository);

  //Getter state
  bool get isInitial => _state == MovieLoadingState.initial;
  bool get isLoading => _state == MovieLoadingState.loading;
  bool get isLoaded => _state == MovieLoadingState.loaded;
  bool get isError => _state == MovieLoadingState.error;
  bool get isRefreshing => _state == MovieLoadingState.refreshing;
  bool get isLoadingMore => _state == MovieLoadingState.loadingMore;
  bool get isComplete => _currentPage >= _totalPages;
  bool get hasData => _movies.isNotEmpty;
  bool get canLoadMore => !isLoadingMore && !isComplete && !isRefreshing;

  void _setNewState(MovieLoadingState newState, {String? error}) {
    _state = newState;
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> fetchPopularMovies({bool refresh = false}) async {
    if (refresh) {
      _movies.clear();
      _currentPage = 1;
      _setNewState(MovieLoadingState.refreshing);
    } else {
      _setNewState(MovieLoadingState.loading);
    }

    try {
      final response = await movieRepository.getPopularMovies(page: 1);
      _movies
        ..clear()
        ..addAll(response.results);
      _currentPage = response.page;
      _totalPages = response.totalPages;

      _setNewState(MovieLoadingState.loaded);
    } catch (e) {
      final errorMsg = e.toString();
      ExceptionHandler.handleError(e);
      _setNewState(MovieLoadingState.error, error: errorMsg);
    }
  }

  Future<void> loadMoreMovies() async {
    if (!canLoadMore) return;

    _setNewState(MovieLoadingState.loadingMore);

    try {
      final nextPage = _currentPage + 1;
      final response = await movieRepository.getPopularMovies(page: nextPage);
      _movies.addAll(response.results);
      _currentPage = response.page;
      _totalPages = response.totalPages;

      _setNewState(MovieLoadingState.loaded);
    } catch (e) {
      final errorMsg = e.toString();
      ExceptionHandler.handleError(e);
      _setNewState(MovieLoadingState.error, error: errorMsg);
    }
  }
}
