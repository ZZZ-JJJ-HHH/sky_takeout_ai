<template>
  <div class="cart-page">
    <h2>购物车</h2>
    <div class="cart-content">
      <div class="empty-cart" v-if="cartItems.length === 0">
        <div class="empty-icon">🛒</div>
        <p>购物车是空的</p>
        <button class="go-shopping">去逛逛</button>
      </div>
      <div class="cart-items" v-else>
        <div class="cart-item" v-for="item in cartItems" :key="item.id">
          <div class="item-image">🍔</div>
          <div class="item-info">
            <h3>{{ item.name }}</h3>
            <p class="item-price">¥{{ item.price }}</p>
          </div>
          <div class="item-controls">
            <button class="quantity-btn">-</button>
            <span class="quantity">{{ item.quantity }}</span>
            <button class="quantity-btn">+</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const cartItems = ref([
  { id: 1, name: '美味汉堡', price: 28.8, quantity: 2 },
  { id: 2, name: '可乐', price: 8.8, quantity: 1 }
])
</script>

<style scoped>
.cart-page {
  padding: 16px;
  background-color: #f5f5f5;
  min-height: 100vh;
}

.cart-content {
  background: white;
  border-radius: 12px;
  padding: 20px;
  margin-top: 20px;
}

.empty-cart {
  text-align: center;
  padding: 40px 20px;
}

.empty-icon {
  font-size: 64px;
  margin-bottom: 20px;
}

.empty-cart p {
  font-size: 18px;
  color: #999;
  margin-bottom: 30px;
}

.go-shopping {
  background: #ff6b35;
  color: white;
  border: none;
  padding: 12px 30px;
  border-radius: 24px;
  font-size: 16px;
  cursor: pointer;
}

.cart-item {
  display: flex;
  align-items: center;
  padding: 16px 0;
  border-bottom: 1px solid #eee;
}

.cart-item:last-child {
  border-bottom: none;
}

.item-image {
  width: 60px;
  height: 60px;
  background: #f0f0f0;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  margin-right: 16px;
}

.item-info {
  flex: 1;
}

.item-info h3 {
  margin: 0 0 8px 0;
  font-size: 16px;
  color: #333;
}

.item-price {
  margin: 0;
  font-size: 18px;
  font-weight: bold;
  color: #ff6b35;
}

.item-controls {
  display: flex;
  align-items: center;
  gap: 12px;
}

.quantity-btn {
  width: 30px;
  height: 30px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 50%;
  cursor: pointer;
  font-size: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.quantity {
  font-size: 16px;
  min-width: 30px;
  text-align: center;
}
</style>