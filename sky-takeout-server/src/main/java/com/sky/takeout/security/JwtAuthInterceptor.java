package com.sky.takeout.security;

import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * JWT 登录拦截器，仅拦截后台 /admin/** 接口
 */
@Component
public class JwtAuthInterceptor implements HandlerInterceptor {

    private static final Logger log = LoggerFactory.getLogger(JwtAuthInterceptor.class);

    private final JwtProperties jwtProperties;

    public JwtAuthInterceptor(JwtProperties jwtProperties) {
        this.jwtProperties = jwtProperties;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String headerName = jwtProperties.getHeader();
        String tokenHeader = request.getHeader(headerName);

        if (!StringUtils.hasText(tokenHeader)) {
            log.warn("未获取到请求头 {}，拒绝访问", headerName);
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }

        String prefix = jwtProperties.getTokenPrefix();
        String token = tokenHeader;
        if (StringUtils.hasText(prefix) && tokenHeader.startsWith(prefix + " ")) {
            token = tokenHeader.substring(prefix.length() + 1);
        }

        try {
            Claims claims = JwtUtil.parseToken(token, jwtProperties);
            Long userId = claims.get("userId", Long.class);
            String username = claims.get("username", String.class);
            String role = claims.get("role", String.class);
            LoginEmployeeContext.set(new LoginEmployeeContext.EmployeeInfo(userId, username, role));
            return true;
        } catch (Exception e) {
            log.warn("JWT 解析失败: {}", e.getMessage());
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        LoginEmployeeContext.clear();
    }
}

