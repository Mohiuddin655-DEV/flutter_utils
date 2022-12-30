class FirebaseStorageCallback {

    static final String TAG = "firebase_storage_callback";

    static final int _codeDelete = 10010;
    static final int _codeDownload = 10020;
    static final int _codeUpload = 10030;
    List<String> _finalUrls = [];
    List<Uri> mFinalUris = [];

    final ConnectivityService mNetworkService;

    final StorageReference _reference;

    FirebaseStorageCallback() {
        mNetworkService = NetworkService.getInstance(activity);
        mStorageReference = FirebaseStorage.getInstance().getReference();
    }

    static FirebaseStorageCallback getInstance() {
        return FirebaseStorageCallback();
    }

    StorageReference _getFilePath(String path) {
        return mStorageReference.child(path).child(KeyProvider.generateKey());
    }

    void deleteRequestByUrl(String url) {
        deleteRequestByUrl(url, response -> Log.e(TAG, "deleteByUrl: " + response.getMessage(), response.getException()));
    }

    void deleteRequestByUrl(String url, OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_DELETE);

        if (!mNetworkService.isInternetConnected()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            final StorageReference reference = FirebaseStorage.getInstance().getReferenceFromUrl(url);

            reference.delete()
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(null)));
        }
    }

    void deleteRequestByUrls(List<String> urls) {
        deleteRequestByUrls(urls, response -> Log.e(TAG, "deleteByUrls: " + response.getMessage(), response.getException()));
    }

    void deleteRequestByUrls(List<String> urls, OnCallbackResponseListener<Void> listener) {

        this.mFinalUrls.clear();

        final Response<Void> response = new Response<>(CODE_DELETE);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            for (String url : urls) {

                final StorageReference reference = FirebaseStorage.getInstance().getReferenceFromUrl(url);

                reference
                        .delete()
                        .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                        .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                        .addOnSuccessListener(unused -> {
                            this.mFinalUrls.add("null");
                            if (TaskProvider.isComplete(urls.size(), mFinalUrls.size())) {
                                listener.onResponse(response.setResult(null));
                            }
                        });
            }
        }
    }

    void downloadRequestForBitmap(String url, int byteQuality, OnCallbackResponseListener<Bitmap> listener) {

        final Response<Bitmap> response = new Response<>(CODE_DOWNLOAD);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            final StorageReference fileReference = FirebaseStorage.getInstance().getReferenceFromUrl(url);

            fileReference.getBytes(byteQuality)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, bytes -> {
                        Bitmap bitmap = Converter.toBitmap(bytes);
                        listener.onResponse(response.setResult(bitmap));
                    });
        }
    }

    void downloadRequestForUris(List<String> urls, long byteQuality, OnCallbackResponseListener<List<Uri>> listener) {

        final Response<ArrayList<Uri>> response = new Response<>(CODE_DOWNLOAD);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            for (String url : urls) {

                final StorageReference fileReference = FirebaseStorage.getInstance().getReferenceFromUrl(url);

                fileReference.getBytes(byteQuality)
                        .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                        .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                        .addOnSuccessListener(mActivity, bytes -> {
                            Bitmap bitmap = Converter.toBitmap(bytes);
                            Uri uri = Converter.toUri(mActivity.getApplicationContext(), bitmap);
                            this.mFinalUris.add(0, uri);
                            if (TaskProvider.isComplete(urls.size(), mFinalUris.size())) {
                                listener.onResponse(response.setResult(mFinalUris));
                            }
                        });
            }
        }
    }

    void downloadRequestForUri(String url, long byteQuality, OnCallbackResponseListener<Uri> listener) {

        final Response<Uri> response = new Response<>(CODE_DOWNLOAD);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            final StorageReference fileReference = FirebaseStorage.getInstance().getReferenceFromUrl(url);

            fileReference.getBytes(byteQuality)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, bytes -> {
                        Bitmap bitmap = Converter.toBitmap(bytes);
                        Uri uri = Converter.toUri(mActivity.getApplicationContext(), bitmap);
                        listener.onResponse(response.setResult(uri));
                    });
        }
    }

    void uploadRequestForUrl(String path, Uri uri, OnCallbackResponseListener<String> listener) {

        final Response<String> response = new Response<>(CODE_UPLOAD);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else if (!Validator.isValidString(path)) {
            listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
        } else if (!Validator.isValidObject(uri)) {
            listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
        } else {

            final StorageReference fileReference = getFilePath(path);
            final UploadTask uploadTask = fileReference.putFile(uri);

            uploadTask
                    .addOnProgressListener(mActivity, snapshot -> listener.onResponse(response.setProgress(TaskProvider.getProgress(snapshot))))
                    .addOnPausedListener(mActivity, snapshot -> listener.onResponse(response.setErrorCode(ErrorCode.PAUSED)))
                    .continueWithTask(task -> {
                        if (!task.isSuccessful()) {
                            if (task.getException() != null) throw task.getException();
                        }
                        return fileReference.getDownloadUrl();
                    })
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(downloadUri -> listener.onResponse(response.setResult(Converter.toString(downloadUri))));
        }
    }

    void uploadRequestForUrls(String path, List<Uri> uris, OnCallbackResponseListener<List<String>> listener) {

        final Response<List<String>> response = new Response<>(CODE_UPLOAD);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else if (!Validator.isValidString(path)) {
            listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
        } else if (!Validator.isValidList(uris)) {
            listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
        } else if (!mNetworkService.isInternetConnected()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            for (Uri uri : uris) {

                if (!Validator.isValidObject(uri)) {
                    listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
                } else {

                    final StorageReference fileReference = getFilePath(path);
                    final UploadTask uploadTask = fileReference.putFile(uri);

                    uploadTask
                            .addOnPausedListener(mActivity, snapshot -> listener.onResponse(response.setErrorCode(ErrorCode.PAUSED)))
                            .addOnProgressListener(mActivity, snapshot -> listener.onResponse(response.setProgress(TaskProvider.getProgress(snapshot))))
                            .continueWithTask(task -> {
                                if (!task.isSuccessful()) {
                                    if (task.getException() != null) throw task.getException();
                                }
                                return fileReference.getDownloadUrl();
                            })
                            .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                            .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                            .addOnSuccessListener(downloadUri -> {
                                this.mFinalUrls.add(0, Converter.toString(downloadUri));
                                if (TaskProvider.isComplete(uris.size(), mFinalUrls.size())) {
                                    listener.onResponse(response.setResult(mFinalUrls));
                                }
                            });
                }
            }
        }
    }

    void uploadRequestWithoutProgressForUrl(String path, Uri uri, OnCallbackResponseListener<String> listener) {

        final Response<String> response = new Response<>(CODE_UPLOAD);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else if (!Validator.isValidString(path)) {
            listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
        } else if (!Validator.isValidObject(uri)) {
            listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
        } else {

            final StorageReference fileReference = getFilePath(path);
            final UploadTask uploadTask = fileReference.putFile(uri);

            uploadTask
                    .continueWithTask(task -> {
                        if (!task.isSuccessful()) {
                            if (task.getException() != null) throw task.getException();
                        }
                        return fileReference.getDownloadUrl();
                    })
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(downloadUri -> listener.onResponse(response.setResult(Converter.toString(downloadUri))));
        }
    }

    void uploadRequestWithoutProgressForUrls(String path, List<Uri> uris, OnCallbackResponseListener<List<String>> listener) {

        final Response<List<String>> response = new Response<>(CODE_UPLOAD);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else if (!Validator.isValidString(path)) {
            listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
        } else if (!Validator.isValidList(uris)) {
            listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
        } else if (!mNetworkService.isInternetConnected()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            for (Uri uri : uris) {

                if (!Validator.isValidObject(uri)) {
                    listener.onResponse(response.setErrorCode(ErrorCode.NULLABLE_OBJECT));
                } else {

                    final StorageReference fileReference = getFilePath(path);
                    final UploadTask uploadTask = fileReference.putFile(uri);

                    uploadTask.continueWithTask(task -> {
                                if (!task.isSuccessful()) {
                                    if (task.getException() != null) throw task.getException();
                                }
                                return fileReference.getDownloadUrl();
                            })
                            .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                            .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                            .addOnSuccessListener(downloadUri -> {
                                this.mFinalUrls.add(0, Converter.toString(downloadUri));
                                if (TaskProvider.isComplete(uris.size(), mFinalUrls.size())) {
                                    listener.onResponse(response.setResult(mFinalUrls));
                                }
                            });
                }
            }
        }
    }

    bool isInternetUnavailable() {
        return !mNetworkService.isInternetConnected();
    }

}

abstract class OnCallbackResponseListener<T> {
    void onResponse(@NonNull Response<T> response);
}
