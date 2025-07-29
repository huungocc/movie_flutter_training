import 'package:movie_flutter_training/common/app_navigator.dart';
import 'package:movie_flutter_training/router/router_config.dart';

class ListMovieNavigator extends AppNavigator {
  ListMovieNavigator({required super.context});

  void navigateToDetail(int id) {
    pushNamed(AppRouter.detailMovie, extra: id);
  }
}
