import 'package:flutter_utils/core/utils/annotations/int_def.dart';

@IntDef([
  ErrorCode.CANCELED,
  ErrorCode.FAILURE,
  ErrorCode.NETWORK_UNAVAILABLE,
  ErrorCode.NULLABLE_OBJECT,
  ErrorCode.PAUSED,
  ErrorCode.RESULT_NOT_FOUND,
  ErrorCode.STOPPED,
  ErrorCode.TIME_OUT
])
class ErrorCode {
  static const int NONE = 10000;
  static const int CANCELED = 10010;
  static const int FAILURE = 10020;
  static const int NETWORK_UNAVAILABLE = 10030;
  static const int NULLABLE_OBJECT = 10040;
  static const int PAUSED = 10050;
  static const int RESULT_NOT_FOUND = 10060;
  static const int STOPPED = 10070;
  static const int TIME_OUT = 10080;
}
