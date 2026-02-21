package com.sky.takeout.service;

import com.sky.takeout.domain.dto.EmployeeLoginDTO;
import com.sky.takeout.domain.vo.EmployeeLoginVO;

public interface EmployeeService {

    /**
     * 员工登录
     */
    EmployeeLoginVO login(EmployeeLoginDTO dto);
}

