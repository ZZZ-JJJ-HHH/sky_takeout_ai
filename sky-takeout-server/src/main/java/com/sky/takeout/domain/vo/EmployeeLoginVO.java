package com.sky.takeout.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 员工登录返回数据
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "员工登录响应数据")
public class EmployeeLoginVO {

    /** JWT token */
    @Schema(description = "认证令牌", example = "eyJhbGciOiJIUzI1NiJ9.xxxxx")
    private String token;

    /** 员工姓名 */
    @Schema(description = "员工姓名", example = "张三")
    private String name;

    /** 角色 */
    @Schema(description = "员工角色", example = "ADMIN")
    private String role;
}

