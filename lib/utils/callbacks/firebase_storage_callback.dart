import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../providers/connectivity_provider.dart';
import '../providers/key_provider.dart';
import '../responses/response.dart';

class FirebaseStorageCallback {
  final _codeDelete = 10010;
  final _codeDownload = 10020;
  final _codeUpload = 10030;
  final _tempData = <Uint8List?>[];
  final _tempUrls = <String>[];

  late Reference _reference;
  late ConnectivityProvider _connectivity;

  Future<bool> get isConnected async => await _connectivity.isConnected;

  FirebaseStorageCallback() {
    _connectivity = ConnectivityProvider.I;
    _reference = FirebaseStorage.instance.ref();
  }

  static FirebaseStorageCallback getInstance() {
    return FirebaseStorageCallback();
  }

  Reference getFilePath(String path) {
    return _reference.child(path).child(KeyProvider.generateKey());
  }

  void deleteRequestByUrl(
    String url,
    OnCallbackResponseListener<void> listener,
  ) async {
    final Response response = Response(_codeDelete);

    if (await isConnected) {
      listener
          .onResponse(response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE));
    } else {
      final Reference reference = FirebaseStorage.instance.refFromURL(url);

      reference
          .delete()
          .then((value) => listener.onResponse(response.withResult(null)))
          .onError((e, s) => listener.onResponse(response
              .withErrorStatus(ErrorCode.FAILURE)
              .withException(exception: e)));
    }
  }

  void deleteRequestByUrls(
    List<String> urls,
    OnCallbackResponseListener<void> listener,
  ) async {
    _tempUrls.clear();

    final response = Response(_codeDelete);

    if (await isConnected) {
      listener
          .onResponse(response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE));
    } else {
      for (String url in urls) {
        final reference = FirebaseStorage.instance.refFromURL(url);

        reference.delete().onError(
          (e, s) {
            listener.onResponse(
              response
                  .withErrorStatus(ErrorCode.FAILURE)
                  .withException(exception: e),
            );
          },
        ).then((value) {
          _tempUrls.add("null");
          if (TaskProvider.isComplete(urls.length, _tempUrls.length)) {
            listener.onResponse(response.withResult(null));
          }
        });
      }
    }
  }

  void downloadRequestSingle(
    String url,
    int byteQuality,
    OnCallbackResponseListener<Uint8List?> listener,
  ) async {
    final response = Response<Uint8List?>(_codeDownload);

    if (await isConnected) {
      listener.onResponse(
        response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE),
      );
    } else {
      final fileReference = FirebaseStorage.instance.refFromURL(url);

      fileReference.getData(byteQuality).onError((e, s) {
        listener.onResponse(
          response
              .withErrorStatus(ErrorCode.FAILURE)
              .withException(exception: e),
        );
        return null;
      }).then((value) {
        listener.onResponse(response.withResult(value));
      });
    }
  }

  void downloadRequestForMultiple(
    List<String> urls,
    int byteQuality,
    OnCallbackResponseListener<List<Uint8List?>> listener,
  ) async {
    final response = Response<List<Uint8List?>>(_codeDownload);

    if (await isConnected) {
      listener.onResponse(
        response.withErrorStatus(ErrorCode.NETWORK_UNAVAILABLE),
      );
    } else {
      for (String url in urls) {
        final fileReference = FirebaseStorage.instance.refFromURL(url);

        fileReference.getData(byteQuality).onError((e, s) {
          listener.onResponse(
            response
                .withErrorStatus(ErrorCode.FAILURE)
                .withException(exception: e),
          );
          return null;
        }).then((value) {
          _tempData.insert(0, value);
          if (TaskProvider.isComplete(urls.length, _tempData.length)) {
            listener.onResponse(response.withResult(_tempData));
          }
        });
      }
    }
  }

  void upload(
    String path,
    dynamic file,
    OnCallbackResponseListener<String> listener,
  ) async {
    final response = Response<String>(_codeUpload);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      final Reference fileReference = getFilePath(path);
      final UploadTask uploadTask = fileReference.putBlob(file);

      uploadTask.snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.paused:
            response.errorStatus = ErrorCode.PAUSED;
            listener.onResponse(response);
            break;
          case TaskState.running:
            response.errorStatus = ErrorCode.RUNNING;
            response.progress = TaskProvider.getProgress(event);
            listener.onResponse(response);
            break;
          case TaskState.success:
            final url = await fileReference.getDownloadURL();
            listener.onResponse(response.withResult(url));
            break;
          case TaskState.canceled:
            response.errorStatus = ErrorCode.CANCELED;
            listener.onResponse(response);
            break;
          case TaskState.error:
            response.errorStatus = ErrorCode.ERROR;
            listener.onResponse(response);
            break;
        }
      }).onError((e) {
        listener.onResponse(response.withException(exception: e));
      });
    }
  }

  void uploadFile(
    String path,
    File file,
    OnCallbackResponseListener<String> listener,
  ) async {
    final response = Response<String>(_codeUpload);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      final Reference fileReference = getFilePath(path);
      final UploadTask uploadTask = fileReference.putFile(file);

      uploadTask.snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.paused:
            response.errorStatus = ErrorCode.PAUSED;
            listener.onResponse(response);
            break;
          case TaskState.running:
            response.errorStatus = ErrorCode.RUNNING;
            response.progress = TaskProvider.getProgress(event);
            listener.onResponse(response);
            break;
          case TaskState.success:
            final url = await fileReference.getDownloadURL();
            listener.onResponse(response.withResult(url));
            break;
          case TaskState.canceled:
            response.errorStatus = ErrorCode.CANCELED;
            listener.onResponse(response);
            break;
          case TaskState.error:
            response.errorStatus = ErrorCode.ERROR;
            listener.onResponse(response);
            break;
        }
      }).onError((e) {
        listener.onResponse(response.withException(exception: e));
      });
    }
  }

  void uploadSingle(
    String path,
    Uint8List data,
    OnCallbackResponseListener<String> listener,
  ) async {
    final response = Response<String>(_codeUpload);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      final Reference fileReference = getFilePath(path);
      final UploadTask uploadTask = fileReference.putData(data);

      uploadTask.snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.paused:
            response.errorStatus = ErrorCode.PAUSED;
            listener.onResponse(response);
            break;
          case TaskState.running:
            response.errorStatus = ErrorCode.RUNNING;
            response.progress = TaskProvider.getProgress(event);
            listener.onResponse(response);
            break;
          case TaskState.success:
            final url = await fileReference.getDownloadURL();
            listener.onResponse(response.withResult(url));
            break;
          case TaskState.canceled:
            response.errorStatus = ErrorCode.CANCELED;
            listener.onResponse(response);
            break;
          case TaskState.error:
            response.errorStatus = ErrorCode.ERROR;
            listener.onResponse(response);
            break;
        }
      }).onError((e) {
        listener.onResponse(response.withException(exception: e));
      });
    }
  }

  void uploads(
    String path,
    List<dynamic> files,
    OnCallbackResponseListener<List<String>> listener,
  ) async {
    final response = Response<List<String>>(_codeUpload);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      final Reference fileReference = getFilePath(path);
      for (File file in files) {
        final UploadTask uploadTask = fileReference.putBlob(file);

        uploadTask.snapshotEvents.listen((event) async {
          switch (event.state) {
            case TaskState.paused:
              response.errorStatus = ErrorCode.PAUSED;
              listener.onResponse(response);
              break;
            case TaskState.running:
              response.errorStatus = ErrorCode.RUNNING;
              response.progress = TaskProvider.getProgress(event);
              listener.onResponse(response);
              break;
            case TaskState.success:
              final url = await fileReference.getDownloadURL();
              _tempUrls.insert(0, url);
              if (TaskProvider.isComplete(files.length, _tempUrls.length)) {
                listener.onResponse(response.withResult(_tempUrls));
              }
              break;
            case TaskState.canceled:
              response.errorStatus = ErrorCode.CANCELED;
              listener.onResponse(response);
              break;
            case TaskState.error:
              response.errorStatus = ErrorCode.ERROR;
              listener.onResponse(response);
              break;
          }
        }).onError((e) {
          listener.onResponse(response.withException(exception: e));
        });
      }
    }
  }

  void uploadFiles(
    String path,
    List<File> files,
    OnCallbackResponseListener<List<String>> listener,
  ) async {
    final response = Response<List<String>>(_codeUpload);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      final Reference fileReference = getFilePath(path);
      for (File file in files) {
        final UploadTask uploadTask = fileReference.putFile(file);

        uploadTask.snapshotEvents.listen((event) async {
          switch (event.state) {
            case TaskState.paused:
              response.errorStatus = ErrorCode.PAUSED;
              listener.onResponse(response);
              break;
            case TaskState.running:
              response.errorStatus = ErrorCode.RUNNING;
              response.progress = TaskProvider.getProgress(event);
              listener.onResponse(response);
              break;
            case TaskState.success:
              final url = await fileReference.getDownloadURL();
              _tempUrls.insert(0, url);
              if (TaskProvider.isComplete(files.length, _tempUrls.length)) {
                listener.onResponse(response.withResult(_tempUrls));
              }
              break;
            case TaskState.canceled:
              response.errorStatus = ErrorCode.CANCELED;
              listener.onResponse(response);
              break;
            case TaskState.error:
              response.errorStatus = ErrorCode.ERROR;
              listener.onResponse(response);
              break;
          }
        }).onError((e) {
          listener.onResponse(response.withException(exception: e));
        });
      }
    }
  }

  void uploadMultiple(
    String path,
    List<Uint8List> multipleData,
    OnCallbackResponseListener<List<String>> listener,
  ) async {
    final response = Response<List<String>>(_codeUpload);

    if (await isConnected) {
      response.errorStatus = ErrorCode.NETWORK_UNAVAILABLE;
      listener.onResponse(response);
    } else {
      final Reference fileReference = getFilePath(path);
      for (Uint8List data in multipleData) {
        final UploadTask uploadTask = fileReference.putData(data);

        uploadTask.snapshotEvents.listen((event) async {
          switch (event.state) {
            case TaskState.paused:
              response.errorStatus = ErrorCode.PAUSED;
              listener.onResponse(response);
              break;
            case TaskState.running:
              response.errorStatus = ErrorCode.RUNNING;
              response.progress = TaskProvider.getProgress(event);
              listener.onResponse(response);
              break;
            case TaskState.success:
              final url = await fileReference.getDownloadURL();
              _tempUrls.insert(0, url);
              if (TaskProvider.isComplete(
                  multipleData.length, _tempUrls.length)) {
                listener.onResponse(response.withResult(_tempUrls));
              }
              break;
            case TaskState.canceled:
              response.errorStatus = ErrorCode.CANCELED;
              listener.onResponse(response);
              break;
            case TaskState.error:
              response.errorStatus = ErrorCode.ERROR;
              listener.onResponse(response);
              break;
          }
        }).onError((e) {
          listener.onResponse(response.withException(exception: e));
        });
      }
    }
  }
}

abstract class OnCallbackResponseListener<T> {
  void onResponse(Response<T> response);
}

class TaskProvider {
  const TaskProvider._();

  static bool isComplete(int initial, int progress) => initial == progress;

  static double getProgress(TaskSnapshot snapshot) {
    final transferred = snapshot.bytesTransferred;
    final total = snapshot.totalBytes;
    final progress = 100.0 * (transferred / total);
    return progress;
  }
}
