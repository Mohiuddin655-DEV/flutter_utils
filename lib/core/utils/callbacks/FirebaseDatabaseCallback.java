package com.picon.utils.callbacks;

import android.app.Activity;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.firestore.CollectionReference;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.picon.utils.constains.ErrorCode;
import com.picon.utils.models.KeyValue;
import com.picon.utils.providers.TaskProvider;
import com.picon.utils.response.Response;

import java.util.ArrayList;
import java.util.HashMap;

public class FirebaseDatabaseCallback extends FirebaseStorageCallback {

    public void updateRequestByKey(@NonNull DatabaseReference reference, @NonNull String key, @Nullable Object value) {
        HashMap<String, Object> map = new HashMap<>();
        map.put(key, value);
        updateRequestByKey(reference, map, response -> Log.e(TAG, "updateByKey: " + response.getMessage(), response.getException()));
    }

    public void updateRequestByKey(@NonNull DocumentReference reference, @NonNull String key, @Nullable Object value, @NonNull OnCallbackResponseListener<Void> listener) {
        HashMap<String, Object> map = new HashMap<>();
        map.put(key, value);
        updateRequestByKey(reference, map, listener);
    }

    public void updateRequestByKey(@NonNull DatabaseReference reference, @NonNull HashMap<String, Object> data, @NonNull OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_UPDATE_BY_KEY);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            reference
                    .updateChildren(data)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(null)));
        }
    }

    public void updateRequestByKey(@NonNull DocumentReference reference, @NonNull HashMap<String, Object> data, @NonNull OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_UPDATE_BY_KEY);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            reference
                    .update(data)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(null)));
        }
    }

    public void uploadRequestByKey(@NonNull DatabaseReference reference, @NonNull Object data, @NonNull OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_UPLOAD_BY_KEY);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            reference
                    .setValue(data)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(null)));
        }
    }

    public void uploadRequestByKey(@NonNull DocumentReference reference, @NonNull Object data, @NonNull OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_UPLOAD_BY_KEY);

        if (isInternetUnavailable()) {
            response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE);
            listener.onResponse(response);
        } else {

            reference
                    .set(data)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(null)));
        }
    }

    public void uploadRequestByKey(@NonNull DatabaseReference reference, @NonNull HashMap<String, Object> data, @NonNull OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_UPLOAD_BY_KEY);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            reference
                    .setValue(data)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(null)));
        }
    }

    public void uploadRequestByKey(@NonNull DocumentReference reference, @NonNull HashMap<String, Object> data, @NonNull OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_UPLOAD_BY_KEY);

        if (isInternetUnavailable()) {
            response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE);
            listener.onResponse(response);
        } else {

            reference
                    .set(data)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(null)));
        }
    }

    public void uploadRequestWithKeyValue(@NonNull DatabaseReference reference, @NonNull ArrayList<String> keys, @NonNull ArrayList<Object> values) {
        if (keys.size() > 0 && keys.size() == values.size()) {
            ArrayList<KeyValue> keyValues = new ArrayList<>();
            for (int index = 0; index < keys.size(); index++) {
                keyValues.add(new KeyValue(keys.get(0), values.get(0)));
            }
            uploadRequestWithKeyValue(reference, keyValues, response -> Log.e(TAG, "uploadRequestWithKeyValue: " + response.getMessage(), response.getException()));
        }
    }

    public void uploadRequestWithKeyValue(@NonNull CollectionReference reference, @NonNull ArrayList<String> keys, @NonNull ArrayList<Object> values) {
        if (keys.size() > 0 && keys.size() == values.size()) {
            ArrayList<KeyValue> keyValues = new ArrayList<>();
            for (int index = 0; index < keys.size(); index++) {
                keyValues.add(new KeyValue(keys.get(0), values.get(0)));
            }
            uploadRequestWithKeyValue(reference, keyValues, response -> Log.e(TAG, "uploadRequestWithKeyValue: " + response.getMessage(), response.getException()));
        }
    }

    public void uploadRequestWithKeyValue(@NonNull DatabaseReference reference, @NonNull ArrayList<KeyValue> keyValues, @NonNull OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_UPLOAD_BY_KEY);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            for (KeyValue keyValue : keyValues) {

                String key = keyValue.getKey();
                Object value = keyValue.getValue();

                reference.child(key)
                        .setValue(value)
                        .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                        .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                        .addOnSuccessListener(unused -> {
                            this.mTemporaryList.add(true);
                            if (TaskProvider.isComplete(keyValues.size(), mTemporaryList.size())) {
                                listener.onResponse(response.setResult(null));
                            }
                        });
            }
        }
    }

    public void uploadRequestWithKeyValue(@NonNull CollectionReference reference, @NonNull ArrayList<KeyValue> keyValues, @NonNull OnCallbackResponseListener<Void> listener) {

        final Response<Void> response = new Response<>(CODE_UPLOAD_BY_KEY);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            for (KeyValue keyValue : keyValues) {

                String key = keyValue.getKey();
                Object value = keyValue.getValue();

                if (value != null) {

                    reference.document(key)
                            .set(value)
                            .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                            .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                            .addOnSuccessListener(unused -> {
                                this.mTemporaryList.add(true);
                                if (TaskProvider.isComplete(keyValues.size(), mTemporaryList.size())) {
                                    listener.onResponse(response.setResult(null));
                                }
                            });
                }
            }
        }
    }

    public <T> void uploadRequestWithFeedback(@NonNull DatabaseReference reference, @NonNull T data, @NonNull OnCallbackResponseListener<T> listener) {

        final Response<T> response = new Response<>(CODE_UPLOAD_BY_KEY);

        if (isInternetUnavailable()) {
            listener.onResponse(response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE));
        } else {

            reference
                    .setValue(data)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(data)));
        }
    }

    public <T> void uploadRequestWithFeedback(@NonNull DocumentReference reference, @NonNull T data, @NonNull OnCallbackResponseListener<T> listener) {

        final Response<T> response = new Response<>(CODE_UPLOAD_BY_KEY);

        if (isInternetUnavailable()) {
            response.setErrorCode(ErrorCode.NETWORK_UNAVAILABLE);
            listener.onResponse(response);
        } else {

            reference
                    .set(data)
                    .addOnCanceledListener(mActivity, () -> listener.onResponse(response.setErrorCode(ErrorCode.CANCELED)))
                    .addOnFailureListener(mActivity, e -> listener.onResponse(response.setErrorCode(ErrorCode.FAILURE).setException(e)))
                    .addOnSuccessListener(mActivity, unused -> listener.onResponse(response.setResult(data)));
        }
    }

}