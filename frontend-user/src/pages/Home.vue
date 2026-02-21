<template>
  <div class="home-page">
    <div class="header">
      <h1>苍穹外卖</h1>
      <p>美味直达，用心服务</p>
    </div>
    
    <div class="search-bar">
      <input 
        type="text" 
        placeholder="搜索美食..."
        class="search-input"
      >
    </div>
    
    <div class="banner">
      <div class="banner-item">今日特价</div>
      <div class="banner-item">新品推荐</div>
      <div class="banner-item">热销榜单</div>
    </div>
    
    <div class="categories">
      <h2>热门分类</h2>
      <div class="category-grid">
        <div class="category-item" v-for="i in 8" :key="i">
          <div class="category-icon">🍽️</div>
          <span>分类{{ i }}</span>
        </div>
      </div>
    </div>
    
    <div class="recommend">
      <h2>为你推荐</h2>
      <div class="product-list">
        <div class="product-card" v-for="i in 6" :key="i">
          <div class="product-image">🍔</div>
          <div class="product-info">
            <h3>美味汉堡{{ i }}</h3>
            <p class="product-desc">精选优质食材，口感丰富</p>
            <div class="product-footer">
              <span class="price">¥28.8</span>
              <button class="add-btn">+</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// 首页逻辑
</script>

<style scoped>
.home-page {
  padding: 16px;
  padding-bottom: 60px;
  background-color: #f5f5f5;
  min-height: 100vh;
}

.header {
  text-align: center;
  padding: 20px 0;
  background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
  color: white;
  border-radius: 12px;
  margin-bottom: 20px;
}

.header h1 {
  margin: 0 0 8px 0;
  font-size: 24px;
}

.header p {
  margin: 0;
  opacity: 0.9;
}

.search-bar {
  margin-bottom: 20px;
}

.search-input {
  width: 100%;
  padding: 12px 16px;
  border: none;
  border-radius: 24px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  font-size: 16px;
}

.banner {
  display: flex;
  gap: 12px;
  margin-bottom: 24px;
}

.banner-item {
  flex: 1;
  background: white;
  padding: 16px;
  border-radius: 12px;
  text-align: center;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  font-weight: 500;
}

.categories h2,
.recommend h2 {
  margin: 0 0 16px 0;
  font-size: 18px;
  color: #333;
}

.category-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.category-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.category-icon {
  width: 50px;
  height: 50px;
  background: #ff6b35;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

.category-item span {
  font-size: 12px;
  color: #666;
}

.product-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.product-card {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  display: flex;
}

.product-image {
  width: 120px;
  height: 120px;
  background: #f0f0f0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
}

.product-info {
  flex: 1;
  padding: 16px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.product-info h3 {
  margin: 0 0 8px 0;
  font-size: 16px;
  color: #333;
}

.product-desc {
  margin: 0 0 12px 0;
  font-size: 14px;
  color: #999;
  flex: 1;
}

.product-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.price {
  font-size: 18px;
  font-weight: bold;
  color: #ff6b35;
}

.add-btn {
  width: 32px;
  height: 32px;
  background: #ff6b35;
  color: white;
  border: none;
  border-radius: 50%;
  font-size: 20px;
  cursor: pointer;
}
</style>