import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';


class ExceptionHandler {
  static bool _isShowingSnackBar = false;

  static String handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return S.current.error_connection_timeout;
      case DioExceptionType.receiveTimeout:
        return S.current.error_receive_timeout;
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            return S.current.error_400;
          case 401:
            return S.current.error_401;
          case 403:
            return S.current.error_403;
          case 404:
            return S.current.error_404;
          case 500:
            return S.current.error_500;
          case 502:
            return S.current.error_502;
          case 503:
            return S.current.error_503;
          default:
            return S.current.error_unknown_server(statusCode.toString());
        }
      case DioExceptionType.connectionError:
        return S.current.error_no_connection;
      case DioExceptionType.cancel:
        return S.current.error_canceled;
      case DioExceptionType.sendTimeout:
        return S.current.error_send_timeout;
      case DioExceptionType.badCertificate:
        return S.current.error_bad_certificate;
      default:
        return S.current.error_unknown(e.message ?? '');
    }
  }

  static String handleSyntaxError(dynamic error) {
    if (error is FormatException) {
      return S.current.syntax_error_format(error.message);
    } else if (error is TypeError) {
      return S.current.syntax_error_type;
    } else if (error is NoSuchMethodError) {
      return S.current.syntax_error_no_method;
    } else if (error is RangeError) {
      return S.current.syntax_error_range(error.message ?? '');
    } else if (error is ArgumentError) {
      return S.current.syntax_error_argument(error.message ?? '');
    } else if (error is StateError) {
      return S.current.syntax_error_state(error.message);
    } else if (error is UnsupportedError) {
      return S.current.syntax_error_unsupported(error.message ?? '');
    } else if (error is UnimplementedError) {
      return S.current.syntax_error_unimplemented;
    } else if (error is AssertionError) {
      return S.current.syntax_error_assertion(error.message ?? '');
    } else {
      return S.current.error_unknown(error.toString());
    }
  }

  static void showSuccessSnackBar(String message) {
    final context = NavigationConfig.context;
    if (context != null && !_isShowingSnackBar) {
      _isShowingSnackBar = true;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: BaseTextLabel(message),
          backgroundColor: Colors.greenAccent,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ).closed.then((_) {
        _isShowingSnackBar = false;
      });
    }
  }

  static void showErrorSnackBar(String message) {
    final context = NavigationConfig.context;
    if (context != null && !_isShowingSnackBar) {
      _isShowingSnackBar = true;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: BaseTextLabel(message),
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ).closed.then((_) {
        _isShowingSnackBar = false;
      });
    }
  }
}