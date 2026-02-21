<script setup lang="ts">
import { RouterView } from 'vue-router'
import { useUserStore } from '@/store/user'
import { ElMessageBox } from 'element-plus'

const userStore = useUserStore()

const handleLogout = async () => {
  try {
    await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    await userStore.logout()
    window.location.reload()
  } catch (error) {
    // 用户取消操作
  }
}
</script>

<template>
  <div class="app-container">
    <!-- 仅在登录状态下显示头部 -->
    <header v-if="userStore.isLoggedIn" class="app-header">
      <div class="header-left">
        <h1>苍穹外卖管理后台</h1>
      </div>
      <div class="header-right">
        <span class="welcome-text">欢迎，{{ userStore.userName }}</span>
        <el-button 
          type="primary" 
          link 
          @click="handleLogout"
          class="logout-btn"
        >
          退出登录
        </el-button>
      </div>
    </header>
    <main class="app-main">
      <RouterView />
    </main>
  </div>
</template>

<style>
html, body, #app {
  height: 100%;
  margin: 0;
  padding: 0;
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', Arial, sans-serif;
}

* {
  box-sizing: border-box;
}

.app-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.app-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 0 2rem;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.header-left h1 {
  margin: 0;
  font-size: 1.5rem;
  font-weight: 600;
}

.header-right {
  display: flex;
  align-items: center;
  gap: 20px;
}

.welcome-text {
  font-size: 0.9rem;
}

.logout-btn {
  color: white !important;
  font-weight: 500;
}

.logout-btn:hover {
  color: #e6f7ff !important;
}

.app-main {
  flex: 1;
  padding: 2rem;
  background-color: #f5f7fa;
}
</style>