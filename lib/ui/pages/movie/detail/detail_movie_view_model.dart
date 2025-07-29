import 'package:flutter/material.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/utils/exception_handler.dart';

enum MovieDetailState {
  initial,
  loading,
  loaded,
  error,
}

class DetailMovieProvider extends ChangeNotifier {
  final MovieRepositoryImpl movieRepository;

  MovieDetailState _state = MovieDetailState.initial;
  MovieDetailState get state => _state;

  MovieEntity? _movieEntity;
  MovieEntity? get movieEntity => _movieEntity;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DetailMovieProvider(this.movieRepository);

  // Getters state
  bool get isInitial => _state == MovieDetailState.initial;
  bool get isLoading => _state == MovieDetailState.loading;
  bool get isLoaded => _state == MovieDetailState.loaded;
  bool get isError => _state == MovieDetailState.error;
  bool get hasData => _movieEntity != null;

  void _setNewState(MovieDetailState newState, {String? error}) {
    _state = newState;
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadSingleMovie(int id) async {
    _setNewState(MovieDetailState.loading);

    try {
      _movieEntity = await movieRepository.getDetailMovie(id: id);
      _setNewState(MovieDetailState.loaded);
    } catch (e) {
      final errorMsg = e.toString();
      ExceptionHandler.handleError(e);
      _setNewState(MovieDetailState.error, error: errorMsg);
    }
  }
}