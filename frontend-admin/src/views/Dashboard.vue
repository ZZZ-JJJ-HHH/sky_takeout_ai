<template>
  <div class="dashboard">
    <h2>管理后台首页</h2>
    <div class="stats-grid">
      <div class="stat-card">
        <h3>今日订单</h3>
        <p class="stat-number">128</p>
      </div>
      <div class="stat-card">
        <h3>今日营业额</h3>
        <p class="stat-number">¥25,680</p>
      </div>
      <div class="stat-card">
        <h3>新增用户</h3>
        <p class="stat-number">45</p>
      </div>
    </div>
    
    <div class="quick-actions">
      <h3>快捷操作</h3>
      <div class="actions-grid">
        <button class="action-btn" @click="$router.push('/login')">员工管理</button>
        <button class="action-btn">菜品管理</button>
        <button class="action-btn">订单管理</button>
        <button class="action-btn">数据统计</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// 这里可以添加dashboard的逻辑
</script>

<style scoped>
.dashboard {
  max-width: 1200px;
  margin: 0 auto;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin: 2rem 0;
}

.stat-card {
  background: white;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  text-align: center;
}

.stat-number {
  font-size: 2rem;
  font-weight: bold;
  color: #409eff;
  margin: 0.5rem 0 0;
}

.quick-actions {
  margin-top: 2rem;
}

.actions-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
  margin-top: 1rem;
}

.action-btn {
  background: #409eff;
  color: white;
  border: none;
  padding: 1rem;
  border-radius: 6px;
  cursor: pointer;
  font-size: 1rem;
  transition: background-color 0.3s;
}

.action-btn:hover {
  background: #66b1ff;
}
</style>