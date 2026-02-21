import { defineStore } from 'pinia'
import { ref } from 'vue'
import { authApi } from '@/api/employee'
import { LoginRequest, LoginResponse } from '@/api/types'

// 用户信息接口
export interface UserInfo {
  id: number
  username: string
  name: string
  role: string
}

export const useUserStore = defineStore('user', () => {
  // 状态
  const token = ref<string>(localStorage.getItem('token') || '')
  const userInfo = ref<UserInfo | null>(null)
  
  // Getters
  const isLoggedIn = computed(() => !!token.value)
  const userName = computed(() => userInfo.value?.name || '')
  const userRole = computed(() => userInfo.value?.role || '')
  
  // Actions
  const login = async (loginData: LoginRequest) => {
    try {
      const response: LoginResponse = await authApi.login(loginData)
      
      // 保存token
      token.value = response.token
      localStorage.setItem('token', response.token)
      
      // 保存用户信息
      const parsedToken = parseJwt(response.token)
      userInfo.value = {
        id: parsedToken.employeeId,
        username: loginData.username,
        name: response.name,
        role: response.role || 'admin' // 默认为admin角色
      }
      
      // 保存用户信息到localStorage
      localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
      
      return Promise.resolve()
    } catch (error) {
      return Promise.reject(error)
    }
  }
  
  const logout = async () => {
    try {
      // 调用后端登出接口
      await authApi.logout()
    } catch (error) {
      console.error('登出接口调用失败:', error)
    } finally {
      // 清除本地状态
      token.value = ''
      userInfo.value = null
      localStorage.removeItem('token')
      localStorage.removeItem('userInfo')
    }
  }
  
  const initializeUser = () => {
    // 从localStorage恢复用户信息
    const savedUserInfo = localStorage.getItem('userInfo')
    if (savedUserInfo) {
      try {
        userInfo.value = JSON.parse(savedUserInfo)
      } catch (error) {
        console.error('解析用户信息失败:', error)
        localStorage.removeItem('userInfo')
      }
    }
  }
  
  // 解析JWT token获取用户信息
  const parseJwt = (token: string) => {
    try {
      const base64Url = token.split('.')[1]
      const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/')
      const jsonPayload = decodeURIComponent(
        atob(base64)
          .split('')
          .map(c => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
          .join('')
      )
      return JSON.parse(jsonPayload)
    } catch (error) {
      console.error('解析JWT失败:', error)
      return {}
    }
  }
  
  return {
    // 状态
    token,
    userInfo,
    
    // Getters
    isLoggedIn,
    userName,
    userRole,
    
    // Actions
    login,
    logout,
    initializeUser
  }
})