import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import { useUserStore } from '@/store/user'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    redirect: '/dashboard'
  },
  {
    path: '/login',
    component: () => import('../views/auth/Login.vue'),
    meta: {
      title: '登录',
      requiresAuth: false
    }
  },
  {
    path: '/dashboard',
    component: () => import('../views/Dashboard.vue'),
    meta: {
      title: '首页',
      requiresAuth: true,
      roles: ['admin']
    }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const userStore = useUserStore()
  
  // 如果路由不需要认证，直接通过
  if (to.meta.requiresAuth === false) {
    // 如果已登录且访问登录页，则重定向到首页
    if (to.path === '/login' && userStore.isLoggedIn) {
      next('/')
      return
    }
    next()
    return
  }
  
  // 需要认证的路由
  if (!userStore.isLoggedIn) {
    // 未登录，重定向到登录页
    next('/login')
    return
  }
  
  // 检查角色权限
  if (to.meta.roles && Array.isArray(to.meta.roles)) {
    const requiredRoles = to.meta.roles as string[]
    const userRole = userStore.userRole
    
    if (!requiredRoles.includes(userRole)) {
      // 角色权限不足
      console.error('权限不足，需要角色:', requiredRoles, '当前角色:', userRole)
      // 可以重定向到无权限页面或首页
      next('/')
      return
    }
  }
  
  next()
})

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router