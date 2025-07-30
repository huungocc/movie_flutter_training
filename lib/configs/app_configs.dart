import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_flutter_training/models/enums/language.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = "Movie";

  ///Local
  static const defaultLanguage = Language.english;

  ///DateFormat
  static const dateDisplayFormat = 'dd/MM/yyyy';
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';

  static const dateTimeAPIFormat =
      "YYYY-MM-DDThh:mm:ssTZD"; //Use DateTime.parse(date) instead of ...
  static const dateAPIFormat = 'dd/MM/yyyy';
}

class MovieAPIConfig {
  static final baseUrl = dotenv.env['MOVIE_URL'].toString();
  static final apiKey = dotenv.env['MOVIE_API_KEY'].toString();
  static final imageUrl = dotenv.env['MOVIE_IMAGE_URL'].toString();
}

class NavigationConfig {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static BuildContext? get context => navigatorKey.currentContext;
}
