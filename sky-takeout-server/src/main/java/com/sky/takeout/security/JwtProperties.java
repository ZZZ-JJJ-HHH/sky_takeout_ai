package com.sky.takeout.security;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "security.jwt")
public class JwtProperties {

    /**
     * 签名密钥
     */
    private String secret;

    /**
     * 过期时间（秒）
     */
    private long expireSeconds;

    /**
     * token 前缀，例如 Bearer
     */
    private String tokenPrefix;

    /**
     * 请求头名称
     */
    private String header;
}

