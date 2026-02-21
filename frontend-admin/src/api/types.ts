// 员工登录相关接口定义

export interface LoginRequest {
  username: string
  password: string
}

export interface LoginResponse {
  token: string
  name: string
  role?: string
}

export interface EmployeeInfo {
  id: number
  username: string
  name: string
  phone: string
  sex: string
  idNumber?: string
  status: number
  createTime: string
  updateTime: string
}

// 员工管理相关接口定义
export interface EmployeeCreateRequest {
  username: string
  name: string
  phone: string
  sex?: string
  idNumber?: string
  password: string
}

export interface EmployeeUpdateRequest {
  id: number
  name?: string
  phone?: string
  sex?: string
  idNumber?: string
  status?: number
}

export interface EmployeeQueryParams {
  page?: number
  pageSize?: number
  name?: string
  username?: string
}

export interface PageResponse<T> {
  records: T[]
  total: number
  size: number
  current: number
  pages: number
}