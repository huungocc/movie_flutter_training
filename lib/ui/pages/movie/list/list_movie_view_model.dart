import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/models/enums/load_status.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/utils/exception_handler.dart';

@injectable
class ListMovieProvider extends ChangeNotifier {
  final MovieRepository movieRepository;

  ListLoadStatus _state = ListLoadStatus.initial;
  ListLoadStatus get state => _state;

  int _currentPage = 1;
  int _totalPages = 1;

  List<MovieEntity> _movies = [];
  List<MovieEntity> get movies => _movies;

  ListMovieProvider(this.movieRepository);

  // Getter Load State
  bool get isListMovieInitial => _state == ListLoadStatus.initial;
  bool get isListMovieLoading => _state == ListLoadStatus.loading;
  bool get isListMovieLoaded => _state == ListLoadStatus.success;
  bool get isListMovieFailure => _state == ListLoadStatus.failure;

  bool get isRefreshing => _state == ListLoadStatus.refreshing;
  bool get isLoadingMore => _state == ListLoadStatus.loadingMore;
  bool get isLoadMoreFailure => _state == ListLoadStatus.loadMoreFailure;

  // Getter Condition State
  bool get isLastPage => _currentPage >= _totalPages;
  bool get hasData => _movies.isNotEmpty;
  bool get canLoadMore => !isLoadingMore && !isLastPage && !isRefreshing;

  void _setNewState(ListLoadStatus newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  /// Get First Movie Page
  Future<void> fetchPopularMovies({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _setNewState(ListLoadStatus.refreshing);
    }

    _setNewState(ListLoadStatus.loading);

    try {
      final response = await movieRepository.getPopularMovies(page: 1);
      _movies = response.results;
      _currentPage = response.page;
      _totalPages = response.totalPages;

      _setNewState(ListLoadStatus.success);
    } catch (e) {
      ExceptionHandler.handleError(e);
      _setNewState(ListLoadStatus.failure);
    }
  }

  Future<void> loadMoreMovies() async {
    if (!canLoadMore) return;

    _setNewState(ListLoadStatus.loadingMore);

    try {
      final nextPage = _currentPage + 1;
      final response = await movieRepository.getPopularMovies(page: nextPage);
      _movies.addAll(response.results);

      // Update page number after load more success
      _currentPage = response.page;
      _totalPages = response.totalPages;

      _setNewState(ListLoadStatus.success);
    } catch (e) {
      ExceptionHandler.handleError(e);
      _setNewState(ListLoadStatus.loadMoreFailure);
    }
  }
}
