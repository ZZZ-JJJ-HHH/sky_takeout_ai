package com.sky.takeout.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sky.takeout.common.BusinessException;
import com.sky.takeout.domain.dto.EmployeeLoginDTO;
import com.sky.takeout.domain.entity.Employee;
import com.sky.takeout.domain.vo.EmployeeLoginVO;
import com.sky.takeout.mapper.EmployeeMapper;
import com.sky.takeout.security.JwtProperties;
import com.sky.takeout.security.JwtUtil;
import com.sky.takeout.service.EmployeeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    private static final Logger log = LoggerFactory.getLogger(EmployeeServiceImpl.class);
    
    private final EmployeeMapper employeeMapper;
    private final JwtProperties jwtProperties;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);

    public EmployeeServiceImpl(EmployeeMapper employeeMapper, JwtProperties jwtProperties) {
        this.employeeMapper = employeeMapper;
        this.jwtProperties = jwtProperties;
    }

    @Override
    public EmployeeLoginVO login(EmployeeLoginDTO dto) {
        try {
            Employee employee = employeeMapper.findByUsername(dto.getUsername());
            // 2. 验证用户是否存在
            if (employee == null) {
                log.warn("登录失败：用户名不存在，username={}", dto.getUsername());
                throw new BusinessException(2001, "用户名或密码错误");
            }
            
            log.info("数据库中的密码: {}", employee.getPassword());
            log.info("输入的密码: {}", dto.getPassword());
            
            // 3. 验证账号状态
            if (employee.getStatus() != null && employee.getStatus() == 0) {
                log.warn("登录失败：账号已被禁用，username={}, employeeId={}",
                         dto.getUsername(), employee.getId());
                throw new BusinessException(2002, "账号已被禁用");
            }

            boolean passwordMatch = passwordEncoder.matches(dto.getPassword(), employee.getPassword());

            if (!passwordMatch) {
                log.warn("登录失败：密码错误，username={}, employeeId={}",
                         dto.getUsername(), employee.getId());
                throw new BusinessException(2001, "用户名或密码错误");
            }

            // 5. 生成JWT令牌
            log.info("准备生成JWT令牌，参数: id={}, username={}, role={}", 
                     employee.getId(), employee.getUsername(), employee.getRole());
            
            String token = JwtUtil.generateToken(
                employee.getId(),
                employee.getUsername(),
                employee.getRole(),
                jwtProperties
            );
            
            log.info("JWT令牌生成成功: {}", token);

            log.info("员工登录成功，username={}, employeeId={}, role={}",
                     employee.getUsername(), employee.getId(), employee.getRole());

            return new EmployeeLoginVO(token, employee.getName(), employee.getRole());
        } catch (Exception e) {
            log.error("登录过程中发生异常: ", e);
            throw e;
        }
    }
}

