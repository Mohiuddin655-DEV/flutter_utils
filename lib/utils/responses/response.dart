class Response<T> {
  final int _requestCode;
  ErrorCode? _errorStatus;
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

  set errorStatus(ErrorCode value) => _errorStatus = value;

  Response<T> withErrorStatus(ErrorCode status) {
    withException(status: status);
    return this;
  }

  Response<T> withResult(T result) {
    _result = result;
    _errorStatus = ErrorCode.SUCCESS;
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

  Response<T> withException({ErrorCode? status, dynamic exception}) {
    _errorStatus = status;
    _exception = status != null ? status.message : exception?.toString() ?? '';
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

  Snapshot? getSnapshot<Snapshot>() => _snapshot is Snapshot ? _snapshot : null;

  T? get result => _result is T ? _result as T : null;

  int get requestCode => _requestCode;

  int get errorCode => (_errorStatus ?? ErrorCode.NONE).code;

  String get errorMessage => (_errorStatus ?? ErrorCode.NONE).message;

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

class BaseMessage {
  const BaseMessage._();

  static const String EXCEPTION_INTERNET_DISCONNECTED =
      "Your internet service has disconnected. Please confirm your internet connection.";
  static const String EXCEPTION_PROCESS_CANCELED = "Process has canceled!";
  static const String EXCEPTION_PROCESS_FAILED =
      "Process has failed, please try again!";
  static const String EXCEPTION_PROCESS_PAUSED = "Process has paused!";
  static const String EXCEPTION_PROCESS_STOPPED = "Process has stopped!";
  static const String EXCEPTION_RESULT_NOT_FOUND = "Result not found!";
  static const String EXCEPTION_RESULT_NOT_VALID = "Result not valid!";
  static const String EXCEPTION_TRY_AGAIN =
      "Something went wrong, please try again?";
  static const String EXCEPTION_POSTING_UNSUCCESSFUL =
      "Posting unsuccessful, please try again!";
  static const String EXCEPTION_UPLOADING_UNSUCCESSFUL =
      "Uploading unsuccessful, please try again!";

  static const String MESSAGE_LOADED = "Your process completed";
  static const String MESSAGE_LOADING =
      "Please wait a second. Because process is running...";
}
