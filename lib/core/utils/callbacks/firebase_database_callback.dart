import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_utils/core/utils/enums/error_code.dart';
import 'package:flutter_utils/core/utils/providers/task_provider.dart';

import '../responses/response.dart';
import 'firebase_storage_callback.dart';

class FirebaseDatabaseCallback extends FirebaseStorageCallback {
  static const int CODE_DELETE_BY_KEY = 10010;
  static const int CODE_LOAD_BY_KEY = 10020;
  static const int CODE_UPLOAD_BY_KEY = 10030;
  static const int CODE_UPDATE_BY_KEY = 10030;
  static const int CODE_LOAD_BY_LIST = 10030;

  final List<Object> mTemporaryList = [];

  static FirebaseDatabaseCallback getInstance() {
    return FirebaseDatabaseCallback();
  }

  void deleteRequestByKey(
    dynamic reference,
    OnCallbackResponseListener<void> listener,
  ) async {
    if (reference is DocumentReference) {
      _deleteFromFS(reference, listener);
    } else if (reference is DatabaseReference) {
      _deleteFromDB(reference, listener);
    } else {
      listener.onResponse(Response().withErrorStatus(ErrorCode.INVALID));
    }
  }

  void _deleteFromDB(
    DatabaseReference reference,
    OnCallbackResponseListener<void> listener,
  ) async {
    final response = Response(CODE_DELETE_BY_KEY);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      reference.remove().then((value) {
        listener.onResponse(response.withResult(null));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener.onResponse(response.withException(exception: e));
      });
    }
  }

  void _deleteFromFS(
    DocumentReference reference,
    OnCallbackResponseListener<void> listener,
  ) async {
    final response = Response(CODE_DELETE_BY_KEY);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      reference.delete().then((value) {
        listener.onResponse(response.withResult(null));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener.onResponse(response.withException(exception: e));
      });
    }
  }

  void deleteRequestByKeys(
    dynamic reference,
    List<String> keys,
    OnCallbackResponseListener<void> listener,
  ) async {
    if (reference is CollectionReference) {
      _deletesFromFS(reference, keys, listener);
    } else if (reference is DatabaseReference) {
      _deletesFromDB(reference, keys, listener);
    } else {
      listener.onResponse(Response().withErrorStatus(ErrorCode.INVALID));
    }
  }

  void _deletesFromDB(
    DatabaseReference reference,
    List<String> keys,
    OnCallbackResponseListener<void> listener,
  ) async {
    mTemporaryList.clear();

    final response = Response(CODE_DELETE_BY_KEY);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      for (String key in keys) {
        reference.child(key).remove().then((value) {
          mTemporaryList.add(true);
          if (TaskProvider.isComplete(keys.length, mTemporaryList.length)) {
            listener.onResponse(response.withResult(null));
          }
        }).onError((e, s) {
          response.errorStatus = ErrorCode.FAILURE;
          listener.onResponse(response.withException(exception: e));
        });
      }
    }
  }

  void _deletesFromFS(
    CollectionReference reference,
    List<String> keys,
    OnCallbackResponseListener<void> listener,
  ) async {
    mTemporaryList.clear();

    final response = Response(CODE_DELETE_BY_KEY);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      for (String key in keys) {
        reference.doc(key).delete().then((value) {
          mTemporaryList.add(true);
          if (TaskProvider.isComplete(keys.length, mTemporaryList.length)) {
            listener.onResponse(response.withResult(null));
          }
        }).onError((e, s) {
          response.errorStatus = ErrorCode.FAILURE;
          listener.onResponse(response.withException(exception: e));
        });
      }
    }
  }

  void loadingRequestForDocument<T>(
    dynamic reference,
    T cls,
    OnCallbackResponseListener<T?> listener,
  ) async {
    if (reference is DocumentReference) {
      _loadingFromFS(reference, cls, listener);
    } else if (reference is DatabaseReference) {
      _loadingFromDB(reference, cls, listener);
    } else {
      listener.onResponse(Response<T>().withErrorStatus(ErrorCode.INVALID));
    }
  }

  void _loadingFromDB<T>(
    DatabaseReference reference,
    T cls,
    OnCallbackResponseListener<T?> listener,
  ) async {
    final response = Response<T?>(CODE_LOAD_BY_KEY);
    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      listener.onResponse(response);
      reference.get().then((snapshot) {
        bool valid = snapshot.exists;
        if (valid) {
          try {
            dynamic value = snapshot.value;
            if (value != null && value.runtimeType == cls.runtimeType) {
              response.withResult(value as T);
            } else {
              response.withSnapshot(snapshot);
            }
          } on Exception catch (e) {
            response
                .withErrorStatus(ErrorCode.FAILURE)
                .withException(exception: e);
          }
        } else {
          response.withErrorStatus(ErrorCode.RESULT_NOT_FOUND);
        }
        listener.onResponse(response.withValid(valid));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener.onResponse(response.withException(exception: e));
      });
    }
  }

  void _loadingFromFS<T>(
    DocumentReference reference,
    T cls,
    OnCallbackResponseListener<T?> listener,
  ) async {
    final response = Response<T?>(CODE_LOAD_BY_KEY);
    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      listener.onResponse(response);
      reference.get().then((snapshot) {
        bool valid = snapshot.exists;
        if (valid) {
          try {
            dynamic value = snapshot.data();
            if (value != null && value.runtimeType == cls.runtimeType) {
              response.withResult(value as T);
            } else {
              response.withSnapshot(snapshot);
            }
          } on Exception catch (e) {
            response
                .withErrorStatus(ErrorCode.FAILURE)
                .withException(exception: e);
          }
        } else {
          response.withErrorStatus(ErrorCode.RESULT_NOT_FOUND);
        }
        listener.onResponse(response.withValid(valid));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener.onResponse(response.withException(exception: e));
      });
    }
  }

  void loadingRequestForCollection<T>(
    dynamic query,
    T cls,
    OnCallbackResponseListener<List<T>> listener,
  ) async {
    if (query is CollectionReference) {
      _loadingsFromFS(query, cls, listener);
    } else if (query is DatabaseReference) {
      _loadingFromDB(query, cls, listener);
    } else {
      listener
          .onResponse(Response<List<T>>().withErrorStatus(ErrorCode.INVALID));
    }
  }

  void _loadingsFromFS<T>(
    CollectionReference query,
    T cls,
    OnCallbackResponseListener<List<T>> listener,
  ) async {
    final response = Response<List<T>>(CODE_LOAD_BY_LIST);

    if (await isConnected) {
      listener
          .onResponse(response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE));
    } else {
      listener.onResponse(response);
      query.get().then((snapshots) {
        bool valid = snapshots.size > 0;
        if (valid) {
          List<T> list = [];
          for (DocumentSnapshot snapshot in snapshots.docs) {
            if (snapshot.exists) {
              try {
                dynamic value = snapshot.data();
                if (value != null && value.runtimeType == cls.runtimeType) {
                  list.add(value as T);
                }
              } on Exception catch (e) {
                response
                    .withErrorStatus(ErrorCode.FAILURE)
                    .withException(exception: e);
              }
            }
          }
        } else {
          response.withErrorStatus(ErrorCode.RESULT_NOT_FOUND);
        }
        listener.onResponse(response.withValid(valid));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener.onResponse(response.withException(exception: e));
      });
    }
  }

  void _loadingsFromDB<T>(
    DatabaseReference query,
    T cls,
    OnCallbackResponseListener<List<T>> listener,
  ) async {
    final response = Response<List<T>>(CODE_LOAD_BY_LIST);

    if (await isConnected) {
      listener
          .onResponse(response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE));
    } else {
      listener.onResponse(response);
      query.get().then((snapshots) {
        bool valid = snapshots.children.isNotEmpty;
        if (valid) {
          List<T> list = [];
          for (DataSnapshot snapshot in snapshots.children) {
            if (snapshot.exists) {
              try {
                dynamic value = snapshot.value;
                if (value != null && value.runtimeType == cls.runtimeType) {
                  list.add(value as T);
                }
              } on Exception catch (e) {
                response
                    .withErrorStatus(ErrorCode.FAILURE)
                    .withException(exception: e);
              }
            }
          }
        } else {
          response.withErrorStatus(ErrorCode.RESULT_NOT_FOUND);
        }
        listener.onResponse(response.withValid(valid));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener.onResponse(response.withException(exception: e));
      });
    }
  }
}
