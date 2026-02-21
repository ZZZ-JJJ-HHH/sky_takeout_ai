package com.sky.takeout.common;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 统一返回结果封装
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "统一响应结果")
public class Result<T> {

    /**
     * 状态码：0 表示成功，非 0 表示失败
     */
    @Schema(description = "状态码", example = "0")
    private Integer code;

    /**
     * 提示信息
     */
    @Schema(description = "提示信息", example = "success")
    private String msg;

    /**
     * 返回数据
     */
    @Schema(description = "响应数据")
    private T data;

    public static <T> Result<T> success(T data) {
        return new Result<>(0, "success", data);
    }

    public static <T> Result<T> success() {
        return new Result<>(0, "success", null);
    }

    public static <T> Result<T> failure(Integer code, String msg) {
        return new Result<>(code, msg, null);
    }
}

