import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { Locale } from 'vant'
import 'vant/lib/index.css'
import './styles/tailwind.css'

import App from './App.vue'
import router from './router'

// 设置 vant 中文
Locale.use('zh-CN')

const app = createApp(App)

app.use(createPinia())
app.use(router)

app.mount('#app')