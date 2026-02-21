package com.sky.takeout.controller.admin;

import com.sky.takeout.common.Result;
import com.sky.takeout.domain.dto.EmployeeLoginDTO;
import com.sky.takeout.domain.vo.EmployeeLoginVO;
import com.sky.takeout.security.LoginEmployeeContext;
import com.sky.takeout.service.EmployeeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/auth")
@Tag(name = "后台-认证授权", description = "后台员工登录、登出")
public class EmployeeAuthController {

    private static final Logger log = LoggerFactory.getLogger(EmployeeAuthController.class);

    private final EmployeeService employeeService;

    public EmployeeAuthController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @PostMapping("/login")
    @Operation(summary = "员工登录", description = "使用用户名和密码进行后台登录，返回 JWT token")
    public Result<EmployeeLoginVO> login(@Valid @RequestBody EmployeeLoginDTO dto) {
        log.info("员工登录请求，username={}", dto.getUsername());
        EmployeeLoginVO vo = employeeService.login(dto);
        return Result.success(vo);
    }

    @PostMapping("/logout")
    @Operation(summary = "员工登出", description = "前端清除本地 token 即可，后端预留接口方便审计")
    public Result<Void> logout() {
        LoginEmployeeContext.EmployeeInfo info = LoginEmployeeContext.get();
        if (info != null) {
            log.info("员工登出，id={}, username={}", info.id(), info.username());
        }
        return Result.success();
    }
}

