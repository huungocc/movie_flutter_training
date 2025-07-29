import 'package:go_router/go_router.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';
import 'package:movie_flutter_training/ui/pages/app_start/splash/splash_page.dart';

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
  ];
}
