import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/key_value.dart';
import '../responses/response.dart';
import 'firebase_storage_callback.dart';

class FirebaseDatabaseCallback extends FirebaseStorageCallback {
  static const int _deleteCode = 10010;
  static const int _loadCode = 10020;
  static const int _uploadCode = 10030;
  static const int _updateCode = 10030;
  static const int _loadingCode = 10030;

  final List<Object> _temp = [];

  static FirebaseDatabaseCallback getInstance() {
    return FirebaseDatabaseCallback();
  }

  void deleteRequestByKey(
    dynamic reference, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    if (reference is DocumentReference) {
      _deleteFromFS(reference, listener: listener);
    } else if (reference is DatabaseReference) {
      _deleteFromDB(reference, listener: listener);
    } else {
      listener?.onResponse(Response().withErrorStatus(ErrorCode.INVALID));
    }
  }

  void _deleteFromDB(
    DatabaseReference reference, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    final response = Response(_deleteCode);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener?.onResponse(response);
    } else {
      reference.remove().then((value) {
        listener?.onResponse(response.withResult(null));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener?.onResponse(response.withException(exception: e));
      });
    }
  }

  void _deleteFromFS(
    DocumentReference reference, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    final response = Response(_deleteCode);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener?.onResponse(response);
    } else {
      reference.delete().then((value) {
        listener?.onResponse(response.withResult(null));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener?.onResponse(response.withException(exception: e));
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
    _temp.clear();

    final response = Response(_deleteCode);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      for (String key in keys) {
        reference.child(key).remove().then((value) {
          _temp.add(true);
          if (TaskProvider.isComplete(keys.length, _temp.length)) {
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
    _temp.clear();

    final response = Response(_deleteCode);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      for (String key in keys) {
        reference.doc(key).delete().then((value) {
          _temp.add(true);
          if (TaskProvider.isComplete(keys.length, _temp.length)) {
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
    final response = Response<T?>(_loadCode);
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
    final response = Response<T?>(_loadCode);
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
    final response = Response<List<T>>(_loadingCode);

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
    final response = Response<List<T>>(_loadingCode);

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

  void updateRequestByKey<T>(
    dynamic reference,
    String key,
    dynamic value, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    Map<String, dynamic> map = {
      key: value,
    };
    if (reference is DocumentReference) {
      _updateToFS(reference, map, listener: listener);
    } else if (reference is DatabaseReference) {
      _updateToDB(reference, map, listener: listener);
    } else {
      listener?.onResponse(
        Response<List<T>>().withErrorStatus(ErrorCode.INVALID),
      );
    }
  }

  void updateRequestByMap<T>(
    dynamic reference,
    Map<String, dynamic> map,
    OnCallbackResponseListener<void> listener,
  ) async {
    if (reference is DocumentReference) {
      _updateToFS(reference, map, listener: listener);
    } else if (reference is DatabaseReference) {
      _updateToDB(reference, map, listener: listener);
    } else {
      listener
          .onResponse(Response<List<T>>().withErrorStatus(ErrorCode.INVALID));
    }
  }

  void _updateToDB(
    DatabaseReference reference,
    Map<String, dynamic> data, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    final response = Response(_updateCode);
    if (await isConnected) {
      listener?.onResponse(
        response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE),
      );
    } else {
      reference.update(data).then((task) {
        listener?.onResponse(response.withResult(null));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener?.onResponse(response.withException(exception: e));
      });
    }
  }

  void _updateToFS(
    DocumentReference reference,
    Map<String, dynamic> data, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    final response = Response(_updateCode);
    if (await isConnected) {
      listener?.onResponse(
        response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE),
      );
    } else {
      reference.update(data).then((task) {
        listener?.onResponse(response.withResult(null));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener?.onResponse(response.withException(exception: e));
      });
    }
  }

  void uploadRequestByKey<T>(
    dynamic reference,
    dynamic data, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    if (reference is DocumentReference) {
      _uploadToFS(reference, data, listener: listener);
    } else if (reference is DatabaseReference) {
      _uploadToDB(reference, data, listener: listener);
    } else {
      listener?.onResponse(Response().withErrorStatus(ErrorCode.INVALID));
    }
  }

  void _uploadToFS(
    DocumentReference reference,
    dynamic data, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    final response = Response(_uploadCode);
    if (await isConnected) {
      listener?.onResponse(
        response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE),
      );
    } else {
      reference.set(data).then((task) {
        listener?.onResponse(response.withResult(null));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener?.onResponse(response.withException(exception: e));
      });
    }
  }

  void _uploadToDB(
    DatabaseReference reference,
    dynamic data, {
    OnCallbackResponseListener<void>? listener,
  }) async {
    final response = Response(_uploadCode);
    if (await isConnected) {
      listener?.onResponse(
        response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE),
      );
    } else {
      reference.set(data).then((task) {
        listener?.onResponse(response.withResult(null));
      }).onError((e, s) {
        response.errorStatus = ErrorCode.FAILURE;
        listener?.onResponse(response.withException(exception: e));
      });
    }
  }

  void uploadRequestWithKeyValue(
    dynamic reference,
    List<KeyValue> data, {
    OnCallbackResponseListener<void>? listener,
    bool feedbackEnable = false,
  }) async {
    if (reference is CollectionReference) {
      _uploadByKeyValueToFS(
        reference,
        data,
        listener: listener,
        feedbackEnable: feedbackEnable,
      );
    } else if (reference is DatabaseReference) {
      _uploadByKeyValueToDB(
        reference,
        data,
        listener: listener,
        feedbackEnable: feedbackEnable,
      );
    } else {
      listener?.onResponse(Response().withErrorStatus(ErrorCode.INVALID));
    }
  }

  void _uploadByKeyValueToFS(
    CollectionReference reference,
    List<KeyValue> keyValues, {
    OnCallbackResponseListener<void>? listener,
    bool feedbackEnable = false,
  }) async {
    final response = Response(_uploadCode);
    if (await isConnected) {
      listener?.onResponse(
        response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE),
      );
    } else {
      for (KeyValue keyValue in keyValues) {
        String key = keyValue.mKey;
        Object value = keyValue.mValue;

        reference.doc(key).set(value).then((task) {
          _temp.add(true);
          if (TaskProvider.isComplete(
            keyValues.length,
            _temp.length,
          )) {
            listener?.onResponse(response.withResult(
              feedbackEnable ? keyValues : null,
            ));
          }
        }).onError((e, s) {
          response.errorStatus = ErrorCode.FAILURE;
          listener?.onResponse(response.withException(exception: e));
        });
      }
    }
  }

  void _uploadByKeyValueToDB(
    DatabaseReference reference,
    List<KeyValue> keyValues, {
    OnCallbackResponseListener<void>? listener,
    bool feedbackEnable = false,
  }) async {
    final response = Response(_uploadCode);
    if (await isConnected) {
      listener?.onResponse(
        response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE),
      );
    } else {
      for (KeyValue keyValue in keyValues) {
        String key = keyValue.mKey;
        Object value = keyValue.mValue;

        reference.child(key).set(value).then((task) {
          _temp.add(true);
          if (TaskProvider.isComplete(
            keyValues.length,
            _temp.length,
          )) {
            listener?.onResponse(response.withResult(
              feedbackEnable ? keyValues : null,
            ));
          }
        }).onError((e, s) {
          response.errorStatus = ErrorCode.FAILURE;
          listener?.onResponse(response.withException(exception: e));
        });
      }
    }
  }
}
