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
