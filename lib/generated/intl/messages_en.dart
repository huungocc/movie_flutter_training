// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "${count} minutes";

  static String m1(message) => "Unknown error: ${message}";

  static String m2(statusCode) => "Server error: ${statusCode}";

  static String m3(message) => "Invalid argument: ${message}";

  static String m4(message) => "Logic error: ${message}";

  static String m5(message) => "Invalid data: ${message}";

  static String m6(message) => "Data access error: ${message}";

  static String m7(message) => "State error: ${message}";

  static String m8(message) => "Unsupported feature: ${message}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "count_minutes": m0,
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "error_400": MessageLookupByLibrary.simpleMessage("Bad request"),
    "error_401": MessageLookupByLibrary.simpleMessage("Unauthorized access"),
    "error_403": MessageLookupByLibrary.simpleMessage("Access forbidden"),
    "error_404": MessageLookupByLibrary.simpleMessage("Data not found"),
    "error_500": MessageLookupByLibrary.simpleMessage("Internal server error"),
    "error_502": MessageLookupByLibrary.simpleMessage("Gateway error"),
    "error_503": MessageLookupByLibrary.simpleMessage("Service unavailable"),
    "error_bad_certificate": MessageLookupByLibrary.simpleMessage(
      "Invalid SSL certificate",
    ),
    "error_canceled": MessageLookupByLibrary.simpleMessage("Request canceled"),
    "error_connection_timeout": MessageLookupByLibrary.simpleMessage(
      "Connection timed out, please try again",
    ),
    "error_no_connection": MessageLookupByLibrary.simpleMessage(
      "No network connection, please check again",
    ),
    "error_receive_timeout": MessageLookupByLibrary.simpleMessage(
      "Receiving data timed out, please try again",
    ),
    "error_send_timeout": MessageLookupByLibrary.simpleMessage(
      "Sending data timed out",
    ),
    "error_unknown": m1,
    "error_unknown_server": m2,
    "loading_movies": MessageLookupByLibrary.simpleMessage("Loading movies..."),
    "movie": MessageLookupByLibrary.simpleMessage("Movies"),
    "syntax_error_argument": m3,
    "syntax_error_assertion": m4,
    "syntax_error_format": m5,
    "syntax_error_no_method": MessageLookupByLibrary.simpleMessage(
      "Processing error: Method does not exist",
    ),
    "syntax_error_range": m6,
    "syntax_error_state": m7,
    "syntax_error_type": MessageLookupByLibrary.simpleMessage(
      "Data processing error: Invalid data type",
    ),
    "syntax_error_unimplemented": MessageLookupByLibrary.simpleMessage(
      "Feature not implemented",
    ),
    "syntax_error_unsupported": m8,
  };
}
