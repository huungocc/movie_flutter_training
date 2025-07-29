// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static String m0(message) => "Lỗi không xác định: ${message}";

  static String m1(statusCode) => "Lỗi máy chủ: ${statusCode}";

  static String m2(message) => "Tham số không hợp lệ: ${message}";

  static String m3(message) => "Lỗi logic: ${message}";

  static String m4(message) => "Dữ liệu không hợp lệ: ${message}";

  static String m5(message) => "Lỗi truy cập dữ liệu: ${message}";

  static String m6(message) => "Lỗi trạng thái: ${message}";

  static String m7(message) => "Chức năng không được hỗ trợ: ${message}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "error_400": MessageLookupByLibrary.simpleMessage("Yêu cầu không hợp lệ"),
    "error_401": MessageLookupByLibrary.simpleMessage(
      "Không có quyền truy cập",
    ),
    "error_403": MessageLookupByLibrary.simpleMessage("Bị từ chối truy cập"),
    "error_404": MessageLookupByLibrary.simpleMessage("Không tìm thấy dữ liệu"),
    "error_500": MessageLookupByLibrary.simpleMessage("Lỗi máy chủ nội bộ"),
    "error_502": MessageLookupByLibrary.simpleMessage("Lỗi gateway"),
    "error_503": MessageLookupByLibrary.simpleMessage("Dịch vụ không khả dụng"),
    "error_bad_certificate": MessageLookupByLibrary.simpleMessage(
      "Chứng chỉ SSL không hợp lệ",
    ),
    "error_canceled": MessageLookupByLibrary.simpleMessage("Yêu cầu đã bị hủy"),
    "error_connection_timeout": MessageLookupByLibrary.simpleMessage(
      "Kết nối quá thời gian, vui lòng thử lại",
    ),
    "error_no_connection": MessageLookupByLibrary.simpleMessage(
      "Không có kết nối mạng, vui lòng kiểm tra lại",
    ),
    "error_receive_timeout": MessageLookupByLibrary.simpleMessage(
      "Nhận dữ liệu quá lâu, vui lòng thử lại",
    ),
    "error_send_timeout": MessageLookupByLibrary.simpleMessage(
      "Gửi dữ liệu quá thời gian",
    ),
    "error_unknown": m0,
    "error_unknown_server": m1,
    "syntax_error_argument": m2,
    "syntax_error_assertion": m3,
    "syntax_error_format": m4,
    "syntax_error_no_method": MessageLookupByLibrary.simpleMessage(
      "Lỗi xử lý: Phương thức không tồn tại",
    ),
    "syntax_error_range": m5,
    "syntax_error_state": m6,
    "syntax_error_type": MessageLookupByLibrary.simpleMessage(
      "Lỗi xử lý dữ liệu: Kiểu dữ liệu không đúng",
    ),
    "syntax_error_unimplemented": MessageLookupByLibrary.simpleMessage(
      "Chức năng chưa được triển khai",
    ),
    "syntax_error_unsupported": m7,
  };
}
