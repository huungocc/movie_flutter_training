// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Connection timed out, please try again`
  String get error_connection_timeout {
    return Intl.message(
      'Connection timed out, please try again',
      name: 'error_connection_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Receiving data timed out, please try again`
  String get error_receive_timeout {
    return Intl.message(
      'Receiving data timed out, please try again',
      name: 'error_receive_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Bad request`
  String get error_400 {
    return Intl.message('Bad request', name: 'error_400', desc: '', args: []);
  }

  /// `Unauthorized access`
  String get error_401 {
    return Intl.message(
      'Unauthorized access',
      name: 'error_401',
      desc: '',
      args: [],
    );
  }

  /// `Access forbidden`
  String get error_403 {
    return Intl.message(
      'Access forbidden',
      name: 'error_403',
      desc: '',
      args: [],
    );
  }

  /// `Data not found`
  String get error_404 {
    return Intl.message(
      'Data not found',
      name: 'error_404',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get error_500 {
    return Intl.message(
      'Internal server error',
      name: 'error_500',
      desc: '',
      args: [],
    );
  }

  /// `Gateway error`
  String get error_502 {
    return Intl.message('Gateway error', name: 'error_502', desc: '', args: []);
  }

  /// `Service unavailable`
  String get error_503 {
    return Intl.message(
      'Service unavailable',
      name: 'error_503',
      desc: '',
      args: [],
    );
  }

  /// `Server error: {statusCode}`
  String error_unknown_server(Object statusCode) {
    return Intl.message(
      'Server error: $statusCode',
      name: 'error_unknown_server',
      desc: '',
      args: [statusCode],
    );
  }

  /// `No network connection, please check again`
  String get error_no_connection {
    return Intl.message(
      'No network connection, please check again',
      name: 'error_no_connection',
      desc: '',
      args: [],
    );
  }

  /// `Request canceled`
  String get error_canceled {
    return Intl.message(
      'Request canceled',
      name: 'error_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Sending data timed out`
  String get error_send_timeout {
    return Intl.message(
      'Sending data timed out',
      name: 'error_send_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Invalid SSL certificate`
  String get error_bad_certificate {
    return Intl.message(
      'Invalid SSL certificate',
      name: 'error_bad_certificate',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error: {message}`
  String error_unknown(Object message) {
    return Intl.message(
      'Unknown error: $message',
      name: 'error_unknown',
      desc: '',
      args: [message],
    );
  }

  /// `Invalid data: {message}`
  String syntax_error_format(Object message) {
    return Intl.message(
      'Invalid data: $message',
      name: 'syntax_error_format',
      desc: '',
      args: [message],
    );
  }

  /// `Data processing error: Invalid data type`
  String get syntax_error_type {
    return Intl.message(
      'Data processing error: Invalid data type',
      name: 'syntax_error_type',
      desc: '',
      args: [],
    );
  }

  /// `Processing error: Method does not exist`
  String get syntax_error_no_method {
    return Intl.message(
      'Processing error: Method does not exist',
      name: 'syntax_error_no_method',
      desc: '',
      args: [],
    );
  }

  /// `Data access error: {message}`
  String syntax_error_range(Object message) {
    return Intl.message(
      'Data access error: $message',
      name: 'syntax_error_range',
      desc: '',
      args: [message],
    );
  }

  /// `Invalid argument: {message}`
  String syntax_error_argument(Object message) {
    return Intl.message(
      'Invalid argument: $message',
      name: 'syntax_error_argument',
      desc: '',
      args: [message],
    );
  }

  /// `State error: {message}`
  String syntax_error_state(Object message) {
    return Intl.message(
      'State error: $message',
      name: 'syntax_error_state',
      desc: '',
      args: [message],
    );
  }

  /// `Unsupported feature: {message}`
  String syntax_error_unsupported(Object message) {
    return Intl.message(
      'Unsupported feature: $message',
      name: 'syntax_error_unsupported',
      desc: '',
      args: [message],
    );
  }

  /// `Feature not implemented`
  String get syntax_error_unimplemented {
    return Intl.message(
      'Feature not implemented',
      name: 'syntax_error_unimplemented',
      desc: '',
      args: [],
    );
  }

  /// `Logic error: {message}`
  String syntax_error_assertion(Object message) {
    return Intl.message(
      'Logic error: $message',
      name: 'syntax_error_assertion',
      desc: '',
      args: [message],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
