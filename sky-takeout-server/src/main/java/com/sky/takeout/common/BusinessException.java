package com.sky.takeout.common;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 业务异常
 */
@Schema(description = "业务异常")
public class BusinessException extends RuntimeException {

    @Schema(description = "错误码")
    private final int code;

    public BusinessException(int code, String message) {
        super(message);
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}

