# 🚀 苍穹外卖 - 完整外卖业务管理系统

<p align="center">
  <img src="https://img.shields.io/badge/Java-17-blue" alt="Java 17">
  <img src="https://img.shields.io/badge/Spring%20Boot-3.3.3-brightgreen" alt="Spring Boot 3.3.3">
  <img src="https://img.shields.io/badge/Vue-3.4.0-green" alt="Vue 3.4.0">
  <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License">
</p>

<p align="center">
  基于Spring Boot 3 + Vue 3的现代化外卖平台解决方案
</p>

## 📖 项目简介

苍穹外卖是一个完整的外卖业务管理系统，包含后端服务和前后端应用。采用现代化的技术栈实现高可用、高性能的企业级应用。

## 🚀 技术栈

### 后端技术栈
- **核心框架**: Spring Boot 3.3.3
- **编程语言**: Java 17
- **持久层**: MyBatis-Plus 3.5.7
- **数据库**: MySQL 8.0
- **缓存**: Redis 7
- **API文档**: SpringDoc OpenAPI
- **安全认证**: JWT + BCrypt
- **容器化**: Docker Compose

### 前端技术栈

#### 管理后台 (frontend-admin)
- **核心框架**: Vue 3.4.0 + TypeScript
- **构建工具**: Vite 5.0.8
- **UI组件库**: Element Plus 2.4.4
- **状态管理**: Pinia 2.1.7
- **路由管理**: Vue Router 4.2.5

#### 用户端 (frontend-user)
- **核心框架**: Vue 3.4.0 + TypeScript
- **构建工具**: Vite 5.0.8
- **UI组件库**: Vant 4.8.0
- **样式框架**: TailwindCSS 3.3.6
- **状态管理**: Pinia 2.1.7
- **路由管理**: Vue Router 4.2.5

## 📁 项目结构

```
sky_takeout_ai/
├── sky-takeout-server/     # 后端服务 (Spring Boot 3)
├── frontend-admin/         # 管理后台前端 (Vue 3 + Element Plus)
├── frontend-user/          # 用户端前端 (Vue 3 + Vant + TailwindCSS)
├── docs/                   # 项目文档
│   ├── backend/           # 后端专用文档
│   ├── frontend/          # 前端专用文档
│   ├── common/            # 前后端通用文档
│   ├── 系统设计/           # 系统架构设计
│   ├── 约束规范/           # 技术规范
│   └── 业务模块详细设计/     # 各模块详细设计
├── db/                     # 数据库脚本
└── docker-compose.yml      # Docker编排文件
```

## 🛠️ 环境搭建

### 环境准备

- Node.js >= 16.0.0 (推荐 18.x LTS)
- Java 17
- Maven 3.8+
- Docker & Docker Compose
- MySQL 8.0+

### 后端启动

```bash
# 启动基础环境
docker-compose up -d

# 初始化数据库
docker exec -i sky-mysql mysql -uroot -proot123456 sky_takeout < db/schema.sql

# 启动后端服务
cd sky-takeout-server
mvn spring-boot:run
```

### 前端启动

```bash
# 启动管理后台 (端口 3000)
cd frontend-admin
npm install
npm run dev

# 启动用户端 (端口 3001)
cd ../frontend-user
npm install
npm run dev
```

## 🌐 访问地址

| 服务 | 地址 | 端口 |
|------|------|------|
| 后端API | http://localhost:8080 | 8080 |
| Swagger UI | http://localhost:8080/swagger-ui.html | 8080 |
| API文档 | http://localhost:8080/v3/api-docs | 8080 |
| 管理后台 | http://localhost:3000 | 3000 |
| 用户端 | http://localhost:3001 | 3001 |
| 数据库 | localhost:3306 | 3306 |

## 📚 文档导航

### 🎯 开发者必读
- [`docs/common/AI开发指引.md`](./docs/common/AI开发指引.md) - AI助手专用开发指引
- [`docs/系统设计/苍穹外卖系统设计文档.md`](./docs/系统设计/苍穹外卖系统设计文档.md) - 系统总体架构设计
- [`docs/约束规范/约束规范文档.md`](./docs/约束规范/约束规范文档.md) - 技术规范与编码标准

### 🖥 后端开发
- [`docs/backend/`](./docs/backend/) - 后端专用文档目录
- [`docs/业务模块详细设计/`](./docs/业务模块详细设计/) - 各业务模块详细设计

### 🎨 前端开发
- [`docs/frontend/前端项目说明.md`](./docs/frontend/前端项目说明.md) - 前端项目通用说明
- [`docs/frontend/管理后台技术规范.md`](./docs/frontend/管理后台技术规范.md) - 管理后台技术规范
- [`docs/frontend/用户端技术规范.md`](./docs/frontend/用户端技术规范.md) - 用户端技术规范

## 🔧 API文档

服务启动后可通过以下地址访问API文档：

- **Swagger UI**: http://localhost:8080/swagger-ui.html
- **OpenAPI JSON**: http://localhost:8080/v3/api-docs

## 🔐 默认登录凭证

```
用户名: admin
密码: admin
```

## 🎯 核心功能模块

### 🔐 认证授权
- 员工登录/登出
- JWT Token认证
- 权限控制

### 📊 商品管理
- 菜品管理（增删改查、上下架、口味配置）
- 套餐管理（组合菜品、价格设置）
- 分类管理（菜品分类、套餐分类）

### 🛒 订单系统
- 用户下单流程
- 订单状态管理
- 模拟支付流程
- 订单查询与取消

### 📈 数据统计
- 营业额统计
- 订单量分析
- 热门菜品排行

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目采用 Apache License 2.0 许可证。

---

<p align="center">Made with ❤️ by Sky Takeout Team</p>

> **注意**: 本项目为学习和演示目的开发，请勿用于生产环境。