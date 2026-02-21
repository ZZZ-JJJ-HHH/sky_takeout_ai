<template>
  <div class="profile-page">
    <div class="user-header">
      <div class="avatar">👤</div>
      <div class="user-info">
        <h2>用户昵称</h2>
        <p>欢迎使用苍穹外卖</p>
      </div>
    </div>
    
    <div class="menu-section">
      <div class="menu-item">
        <span class="menu-icon">📋</span>
        <span class="menu-text">我的订单</span>
        <span class="arrow">›</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">📍</span>
        <span class="menu-text">收货地址</span>
        <span class="arrow">›</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">⭐</span>
        <span class="menu-text">我的收藏</span>
        <span class="arrow">›</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">💳</span>
        <span class="menu-text">优惠券</span>
        <span class="arrow">›</span>
      </div>
    </div>
    
    <div class="menu-section">
      <div class="menu-item">
        <span class="menu-icon">⚙️</span>
        <span class="menu-text">设置</span>
        <span class="arrow">›</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">📞</span>
        <span class="menu-text">客服中心</span>
        <span class="arrow">›</span>
      </div>
    </div>
    
    <button class="logout-btn">退出登录</button>
  </div>
</template>

<script setup lang="ts">
// 个人中心逻辑
</script>

<style scoped>
.profile-page {
  padding: 16px;
  background-color: #f5f5f5;
  min-height: 100vh;
}

.user-header {
  background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
  border-radius: 16px;
  padding: 30px 20px;
  display: flex;
  align-items: center;
  color: white;
  margin-bottom: 20px;
}

.avatar {
  width: 60px;
  height: 60px;
  background: rgba(255,255,255,0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  margin-right: 16px;
}

.user-info h2 {
  margin: 0 0 8px 0;
  font-size: 20px;
}

.user-info p {
  margin: 0;
  opacity: 0.9;
  font-size: 14px;
}

.menu-section {
  background: white;
  border-radius: 12px;
  margin-bottom: 20px;
  overflow: hidden;
}

.menu-item {
  display: flex;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid #eee;
}

.menu-item:last-child {
  border-bottom: none;
}

.menu-icon {
  font-size: 20px;
  margin-right: 16px;
  width: 24px;
  text-align: center;
}

.menu-text {
  flex: 1;
  font-size: 16px;
  color: #333;
}

.arrow {
  color: #ccc;
  font-size: 20px;
}

.logout-btn {
  width: 100%;
  background: white;
  color: #ff6b35;
  border: 1px solid #ff6b35;
  padding: 16px;
  border-radius: 12px;
  font-size: 16px;
  cursor: pointer;
  margin-top: 20px;
}
</style>