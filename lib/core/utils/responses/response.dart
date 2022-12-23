import '../constants/base_messages.dart';
import '../constants/error_code.dart';

class Response<T> {
  int _requestCode = 0;
  int _errorCode = ErrorCode.NONE;
  T? _result;
  String? _feedback;
  dynamic _snapshot;
  String? _exception;
  double _progress = 0;
  bool _available = false;
  bool _successful = false;
  bool _cancel = false;
  bool _complete = false;
  bool _internetError = false;
  bool _valid = false;
  bool _loaded = false;
  bool _paused = false;
  bool _nullableObject = false;
  bool _stopped = false;
  bool _failed = false;
  bool _timeout = false;

  Response([int? requestCode]) {
    _requestCode = requestCode ?? _requestCode;
  }

  int getRequestCode() {
    return _requestCode;
  }

  int getErrorCode() {
    return _errorCode;
  }

  Response<T> setErrorCode(int errorCode) {
    setException(errorCode: errorCode);
    return this;
  }

  T? getResult() {
    return _result;
  }

  Response<T> setResult(T result) {
    _result = result;
    _successful = true;
    _complete = true;
    _loaded = true;
    return this;
  }

  String getFeedback() {
    return _feedback ?? '';
  }

  Response<T> setFeedback(String feedback) {
    _feedback = feedback;
    return this;
  }

  dynamic get snapshot => _snapshot;

  Response<T> setSnapshot(dynamic snapshot) {
    _snapshot = snapshot;
    return this;
  }

  String get exception => _exception ?? '';

  Response<T> setException({int errorCode = 0, String? exception}) {
    _errorCode = errorCode;
    _exception = errorCode != 0 ? getMessage(errorCode) : exception ?? '';
    _feedback = null;
    _complete = true;
    _loaded = true;
    return this;
  }

  String getMessage([int code = 0]) {
    if (code != 0) {
      switch (code) {
        case ErrorCode.CANCELED:
          _cancel = true;
          return BaseMessage.EXCEPTION_PROCESS_CANCELED;
        case ErrorCode.FAILURE:
          _failed = true;
          return BaseMessage.EXCEPTION_PROCESS_FAILED;
        case ErrorCode.NETWORK_UNAVAILABLE:
          _internetError = true;
          _valid = false;
          return BaseMessage.EXCEPTION_INTERNET_DISCONNECTED;
        case ErrorCode.NULLABLE_OBJECT:
          _nullableObject = true;
          return BaseMessage.EXCEPTION_RESULT_NOT_VALID;
        case ErrorCode.PAUSED:
          _paused = true;
          return BaseMessage.EXCEPTION_PROCESS_PAUSED;
        case ErrorCode.RESULT_NOT_FOUND:
          return BaseMessage.EXCEPTION_RESULT_NOT_FOUND;
        case ErrorCode.STOPPED:
          _stopped = true;
          return BaseMessage.EXCEPTION_PROCESS_STOPPED;
        case ErrorCode.TIME_OUT:
          _timeout = true;
          return BaseMessage.EXCEPTION_TRY_AGAIN;
        default:
          return _exception ?? '';
      }
    } else {
      return _exception ?? '';
    }
  }

  bool isSuccessful() {
    return _successful;
  }

  Response<T> setSuccessful(bool successful) {
    _successful = successful;
    _complete = true;
    return this;
  }

  double getProgress() {
    return _progress;
  }

  Response<T> setProgress(double progress) {
    _progress = progress;
    return this;
  }

  bool isAvailable() {
    return _available;
  }

  Response<T> setAvailable(bool available) {
    _available = available;
    return this;
  }

  bool isComplete() {
    return _complete;
  }

  Response<T> setComplete(bool complete) {
    _complete = complete;
    return this;
  }

  bool isCancel() {
    return _cancel;
  }

  Response<T> setCancel(bool cancel) {
    _cancel = cancel;
    return this;
  }

  bool isValid() {
    return _valid;
  }

  Response<T> setValid(bool valid) {
    _valid = valid;
    _loaded = true;
    return this;
  }

  bool isLoaded() {
    return _loaded;
  }

  Response<T> setLoaded(bool loaded) {
    _loaded = loaded;
    return this;
  }

  bool isLoading() {
    return !_loaded;
  }

  bool isInternetConnected() {
    return !_internetError;
  }

  bool isValidException() {
    return _exception != null && _exception!.isNotEmpty;
  }

  bool isInternetError() {
    return _internetError;
  }

  Response<T> setInternetError(String message, [bool? internetError]) {
    setException(exception: message);
    _internetError = internetError ?? true;
    _valid = false;
    return this;
  }

  bool isPaused() {
    return _paused;
  }

  Response<T> setPaused(bool paused) {
    _paused = paused;
    return this;
  }

  bool isNullableObject() {
    return _nullableObject;
  }

  Response<T> setNullableObject(bool nullableObject) {
    _nullableObject = nullableObject;
    return this;
  }

  bool isStopped() {
    return _stopped;
  }

  Response<T> setStopped(bool stopped) {
    _stopped = stopped;
    return this;
  }

  bool isFailed() {
    return _failed;
  }

  Response<T> setFailed(bool failed) {
    _failed = failed;
    return this;
  }

  bool isTimeout() {
    return _timeout;
  }

  Response<T> setTimeout(bool timeout) {
    _timeout = timeout;
    return this;
  }
}
