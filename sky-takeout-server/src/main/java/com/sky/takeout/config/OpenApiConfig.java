package com.sky.takeout.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.servers.Server;
import org.springframework.context.annotation.Configuration;

/**
 * OpenAPI / Knife4j 配置
 *
 * 配置完成后：
 * - Knife4j文档地址：/doc.html
 * - 原始Swagger UI：/swagger-ui.html
 * - OpenAPI JSON：/v3/api-docs
 *   Postman 可以直接导入 /v3/api-docs 生成接口集合
 */
@Configuration
@OpenAPIDefinition(
        info = @Info(
                title = "苍穹外卖（AI 重构版）接口文档",
                version = "v1",
                description = "苍穹外卖后端接口说明",
                contact = @Contact(name = "ZZZ", email = "3056004639@qq.com")
        ),
        servers = {
                @Server(url = "http://localhost:8080", description = "本地开发环境")
        }
)
public class OpenApiConfig {
}

