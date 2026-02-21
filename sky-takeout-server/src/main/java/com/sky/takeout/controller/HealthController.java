package com.sky.takeout.controller;

import com.sky.takeout.common.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 基础健康检查接口
 */
@RestController
@RequestMapping("/api/health")
@Tag(name = "系统健康检查", description = "用于检测服务是否正常运行")
public class HealthController {

    private static final Logger log = LoggerFactory.getLogger(HealthController.class);

    @GetMapping
    @Operation(summary = "健康检查", description = "返回服务当前健康状态")
    public Result<String> health() {
        log.info("健康检查接口被调用!");
        return Result.success("OK");
    }
}

