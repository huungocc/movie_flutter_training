import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/models/enums/load_status.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/utils/exception_handler.dart';

@injectable
class DetailMovieProvider extends ChangeNotifier {
  final MovieRepository movieRepository;

  ItemLoadStatus _state = ItemLoadStatus.initial;
  ItemLoadStatus get state => _state;

  MovieEntity? _movieEntity;
  MovieEntity? get movieEntity => _movieEntity;

  bool _isMovieMark = false;
  bool get isMovieMark => _isMovieMark;

  DetailMovieProvider(this.movieRepository);

  // Getters state
  bool get isMovieDetailInitial => _state == ItemLoadStatus.initial;
  bool get isMovieDetailLoading => _state == ItemLoadStatus.loading;
  bool get isMovieDetailLoaded => _state == ItemLoadStatus.success;
  bool get iMovieDetailsError => _state == ItemLoadStatus.failure;

  // Getters Condition State
  bool get hasData => _movieEntity != null;

  void _setNewState(ItemLoadStatus newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> loadSingleMovie(int id) async {
    _setNewState(ItemLoadStatus.loading);

    try {
      _movieEntity = await movieRepository.getDetailMovie(id: id);
      _setNewState(ItemLoadStatus.success);
    } catch (e) {
      ExceptionHandler.handleError(e);
      _setNewState(ItemLoadStatus.failure);
    }
  }

  void markMovie() {
    _isMovieMark = !_isMovieMark;
    notifyListeners();
  }
}