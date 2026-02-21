import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    redirect: '/home'
  },
  {
    path: '/home',
    component: () => import('../pages/Home.vue'),
    meta: {
      title: '首页'
    }
  },
  {
    path: '/category',
    component: () => import('../pages/Category.vue'),
    meta: {
      title: '分类'
    }
  },
  {
    path: '/cart',
    component: () => import('../pages/Cart.vue'),
    meta: {
      title: '购物车'
    }
  },
  {
    path: '/profile',
    component: () => import('../pages/Profile.vue'),
    meta: {
      title: '我的'
    }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router