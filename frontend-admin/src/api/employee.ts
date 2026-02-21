import request from '@/utils/request'
import { 
  LoginRequest, 
  LoginResponse, 
  EmployeeInfo,
  EmployeeCreateRequest,
  EmployeeUpdateRequest,
  EmployeeQueryParams,
  PageResponse 
} from './types'

// 认证相关API
export const authApi = {
  // 员工登录
  login: (data: LoginRequest): Promise<LoginResponse> => {
    return request.post('/admin/auth/login', data)
  },
  
  // 员工登出
  logout: (): Promise<void> => {
    return request.post('/admin/auth/logout')
  }
}

// 员工管理相关API
export const employeeApi = {
  // 新增员工
  create: (data: EmployeeCreateRequest): Promise<void> => {
    return request.post('/admin/employee', data)
  },
  
  // 查询员工列表（分页）
  getPage: (params: EmployeeQueryParams): Promise<PageResponse<EmployeeInfo>> => {
    return request.get('/admin/employee/page', { params })
  },
  
  // 根据ID查询员工
  getById: (id: number): Promise<EmployeeInfo> => {
    return request.get(`/admin/employee/${id}`)
  },
  
  // 修改员工
  update: (data: EmployeeUpdateRequest): Promise<void> => {
    return request.put('/admin/employee', data)
  },
  
  // 删除员工（逻辑删除）
  delete: (id: number): Promise<void> => {
    return request.delete(`/admin/employee/${id}`)
  }
}