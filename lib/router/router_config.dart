import 'package:go_router/go_router.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';
import 'package:movie_flutter_training/ui/pages/app_start/splash/splash_page.dart';
import 'package:movie_flutter_training/ui/pages/movie/detail/detail_movie_page.dart';
import 'package:movie_flutter_training/ui/pages/movie/list/list_movie_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    routes: _routes,
    debugLogDiagnostics: true,
    navigatorKey: NavigationConfig.navigatorKey,
  );

  ///main page
  static const String splash = "/";
  static const String listMovie = "/listMovie";
  static const String detailMovie = "/detailMovie";

  static final _routes = <RouteBase>[
    GoRoute(
      path: splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: listMovie,
      path: listMovie,
      builder: (context, state) => const ListMoviePage(),
    ),
    GoRoute(
      name: detailMovie,
      path: detailMovie,
      builder: (context, state) => DetailMoviePage(
        arguments: DetailMovieArguments(id: state.extra as int),
      ),
    ),
  ];
}

