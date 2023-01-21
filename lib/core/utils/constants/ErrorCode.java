package com.picon.utils.constains;

import static com.picon.utils.constains.ErrorCode.CANCELED;
import static com.picon.utils.constains.ErrorCode.FAILURE;
import static com.picon.utils.constains.ErrorCode.NETWORK_UNAVAILABLE;
import static com.picon.utils.constains.ErrorCode.NULLABLE_OBJECT;
import static com.picon.utils.constains.ErrorCode.PAUSED;
import static com.picon.utils.constains.ErrorCode.RESULT_NOT_FOUND;
import static com.picon.utils.constains.ErrorCode.STOPPED;
import static com.picon.utils.constains.ErrorCode.TIME_OUT;

import androidx.annotation.IntDef;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.SOURCE)
@Documented
@IntDef({
        CANCELED,
        FAILURE,
        NETWORK_UNAVAILABLE,
        NULLABLE_OBJECT,
        PAUSED,
        RESULT_NOT_FOUND,
        STOPPED,
        TIME_OUT
})
public @interface ErrorCode {
    int CANCELED = 10010;
    int FAILURE = 10020;
    int NETWORK_UNAVAILABLE = 10030;
    int NULLABLE_OBJECT = 10040;
    int PAUSED = 10050;
    int RESULT_NOT_FOUND = 10060;
    int STOPPED = 10070;
    int TIME_OUT = 10080;
}