import '../constants/base_messages.dart';

enum ErrorCode {
  NONE(10000, ""),
  CANCELED(10010, BaseMessage.EXCEPTION_PROCESS_CANCELED),
  FAILURE(10020, BaseMessage.EXCEPTION_PROCESS_FAILED),
  NETWORK_UNAVAILABLE(10030, BaseMessage.EXCEPTION_INTERNET_DISCONNECTED),
  NULLABLE_OBJECT(10040, BaseMessage.EXCEPTION_RESULT_NOT_VALID),
  PAUSED(10050, BaseMessage.EXCEPTION_PROCESS_PAUSED),
  RESULT_NOT_FOUND(10060, BaseMessage.EXCEPTION_RESULT_NOT_FOUND),
  STOPPED(10070, BaseMessage.EXCEPTION_PROCESS_STOPPED),
  RUNNING(10090, ""),
  TIME_OUT(10080, BaseMessage.EXCEPTION_TRY_AGAIN),
  SUCCESS(10100, 'Successful!'),
  INVALID(10110, 'Invalid data!'),
  ERROR(10100, 'Error found!');

  final int code;
  final String message;

  const ErrorCode(this.code, this.message);
}
