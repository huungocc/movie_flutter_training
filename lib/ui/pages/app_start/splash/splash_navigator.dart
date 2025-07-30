import 'package:movie_flutter_training/common/app_navigator.dart';
import 'package:movie_flutter_training/router/router_config.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required super.context});

  void openListMovie() {
    navigateSplash(AppRouter.listMovie);
  }
}
