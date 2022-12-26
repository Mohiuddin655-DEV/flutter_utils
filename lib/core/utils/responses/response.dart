import '../constants/base_messages.dart';
import '../constants/error_code.dart';

class Response<T> {
  final int _requestCode;
  int? _errorCode = ErrorCode.NONE;
  T? _result;
  String? _feedback;
  dynamic _snapshot;
  String? _exception;
  double? _progress;
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

  Response([this._requestCode = 0]);

  set timeout(bool value) => _timeout = value;

  set failed(bool value) => _failed = value;

  set stopped(bool value) => _stopped = value;

  set nullableObject(bool value) => _nullableObject = value;

  set paused(bool value) => _paused = value;

  set loaded(bool value) => _loaded = value;

  set valid(bool value) => _valid = value;

  set internetError(bool value) => _internetError = value;

  set complete(bool value) => _complete = value;

  set cancel(bool value) => _cancel = value;

  set successful(bool value) => _successful = value;

  set available(bool value) => _available = value;

  set progress(double value) => _progress = value;

  set exception(String value) => _exception = value;

  set snapshot(dynamic value) => _snapshot = value;

  set feedback(String value) => _feedback = value;

  set result(T? value) => _result = value;

  set errorCode(int value) => _errorCode = value;

  Response<T> withErrorCode(int errorCode) {
    withException(errorCode: errorCode);
    return this;
  }

  Response<T> withResult(T result) {
    _result = result;
    _successful = true;
    _complete = true;
    _loaded = true;
    return this;
  }

  Response<T> withFeedback(String feedback) {
    _feedback = feedback;
    return this;
  }

  Response<T> withSnapshot(dynamic snapshot) {
    _snapshot = snapshot;
    return this;
  }

  Response<T> withException({int errorCode = 0, String? exception}) {
    _errorCode = errorCode;
    _exception = errorCode != 0 ? message(errorCode) : exception ?? '';
    _feedback = null;
    _complete = true;
    _loaded = true;
    return this;
  }

  Response<T> withSuccessful(bool successful) {
    _successful = successful;
    _complete = true;
    return this;
  }

  Response<T> withProgress(double progress) {
    _progress = progress;
    return this;
  }

  Response<T> withAvailable(bool available) {
    _available = available;
    return this;
  }

  Response<T> withComplete(bool complete) {
    _complete = complete;
    return this;
  }

  Response<T> withCancel(bool cancel) {
    _cancel = cancel;
    return this;
  }

  Response<T> withValid(bool valid) {
    _valid = valid;
    _loaded = true;
    return this;
  }

  Response<T> withLoaded(bool loaded) {
    _loaded = loaded;
    return this;
  }

  Response<T> withInternetError(String message, [bool? internetError]) {
    withException(exception: message);
    _internetError = internetError ?? true;
    _valid = false;
    return this;
  }

  Response<T> withPaused(bool paused) {
    _paused = paused;
    return this;
  }

  Response<T> withNullableObject(bool nullableObject) {
    _nullableObject = nullableObject;
    return this;
  }

  Response<T> withStopped(bool stopped) {
    _stopped = stopped;
    return this;
  }

  Response<T> withFailed(bool failed) {
    _failed = failed;
    return this;
  }

  Response<T> withTimeout(bool timeout) {
    _timeout = timeout;
    return this;
  }

  String message([int code = 0]) {
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

  Snapshot? getSnapshot<Snapshot>() => _snapshot is Snapshot ? _snapshot : null;

  T? get result => _result is T ? _result as T : null;

  int get requestCode => _requestCode;

  int get errorCode => _errorCode ?? ErrorCode.NONE;

  String get feedback => _feedback ?? '';

  String get exception => _exception ?? '';

  bool get isSuccessful => _successful;

  double get progress => _progress ?? 0;

  bool get isAvailable => _available;

  bool get isComplete => _complete;

  bool get isCancel => _cancel;

  bool get isValid => _valid;

  bool get isLoaded => _loaded;

  bool get isLoading => !_loaded;

  bool get isInternetConnected => !_internetError;

  bool get isValidException => _exception != null && _exception!.isNotEmpty;

  bool get isInternetError => _internetError;

  bool get isPaused => _paused;

  bool get isNullableObject => _nullableObject;

  bool get isStopped => _stopped;

  bool get isFailed => _failed;

  bool get isTimeout => _timeout;
}
