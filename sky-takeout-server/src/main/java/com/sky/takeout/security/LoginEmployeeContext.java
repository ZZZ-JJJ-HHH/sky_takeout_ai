package com.sky.takeout.security;

/**
 * 保存当前登录员工信息的上下文
 */
public class LoginEmployeeContext {

    private static final ThreadLocal<EmployeeInfo> CONTEXT = new ThreadLocal<>();

    public static void set(EmployeeInfo info) {
        CONTEXT.set(info);
    }

    public static EmployeeInfo get() {
        return CONTEXT.get();
    }

    public static void clear() {
        CONTEXT.remove();
    }

    public record EmployeeInfo(Long id, String username, String role) {
    }
}

