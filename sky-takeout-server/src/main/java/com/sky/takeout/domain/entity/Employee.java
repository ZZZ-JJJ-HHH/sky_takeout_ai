package com.sky.takeout.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 员工实体
 */
@Data
@TableName("employee")
public class Employee {

    @TableId(type = IdType.AUTO)
    private Long id;

    /** 登录用户名（唯一） */
    private String username;

    /** 登录密码（BCrypt 加密） */
    private String password;

    /** 员工姓名 */
    private String name;

    /** 手机号 */
    private String phone;

    /** 状态：1-启用，0-禁用 */
    private Integer status;

    /** 角色：ADMIN/EMPLOYEE 等 */
    private String role;

    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Long createUser;
    private Long updateUser;
}

