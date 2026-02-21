package com.sky.takeout.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * JWT 工具类
 */
public class JwtUtil {

    public static String generateToken(Long userId, String username, String role, JwtProperties properties) {
        // 参数验证
        System.out.println("JwtUtil.generateToken called with: userId=" + userId + ", username=" + username + ", role=" + role);
        
        if (userId == null) {
            throw new IllegalArgumentException("userId不能为null");
        }
        if (username == null || username.isEmpty()) {
            throw new IllegalArgumentException("username不能为空");
        }
        if (properties == null) {
            throw new IllegalArgumentException("JwtProperties不能为null");
        }
        if (properties.getSecret() == null || properties.getSecret().isEmpty()) {
            throw new IllegalArgumentException("JWT密钥不能为空");
        }
        
        System.out.println("JwtProperties secret: " + properties.getSecret());
        System.out.println("JwtProperties expireSeconds: " + properties.getExpireSeconds());
        
        Map<String, Object> claims = new HashMap<>();
        claims.put("userId", userId);
        claims.put("username", username);
        claims.put("role", role != null ? role : "USER");

        long now = System.currentTimeMillis();
        Date issuedAt = new Date(now);
        Date expiration = new Date(now + properties.getExpireSeconds() * 1000);
        
        System.out.println("Creating JWT with expiration: " + expiration);

        SecretKey key = Keys.hmacShaKeyFor(properties.getSecret().getBytes());
        
        String token = Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(issuedAt)
                .setExpiration(expiration)
                .signWith(key)
                .compact();
                
        System.out.println("JWT token created successfully: " + token);
        return token;
    }

    public static Claims parseToken(String token, JwtProperties properties) {
        return Jwts.parser()
                .setSigningKey(properties.getSecret())
                .parseClaimsJws(token)
                .getBody();
    }
}

