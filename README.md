# 苍穹外卖系统 (Sky Takeout)

<p align="center">
  <img src="https://img.shields.io/badge/Java-17-blue" alt="Java 17">
  <img src="https://img.shields.io/badge/Spring%20Boot-3.3.3-brightgreen" alt="Spring Boot 3.3.3">
  <img src="https://img.shields.io/badge/MyBatis--Plus-3.5.7-orange" alt="MyBatis-Plus 3.5.7">
  <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License">
</p>

## 📖 项目简介

苍穹外卖系统是一个基于AI技术从零构建的完整外卖平台后端系统，采用现代化的技术栈实现高可用、高性能的企业级应用。

## 🚀 技术栈

- **核心框架**: Spring Boot 3.3.3
- **编程语言**: Java 17
- **持久层**: MyBatis-Plus 3.5.7
- **数据库**: MySQL 8.0
- **缓存**: Redis 7
- **API文档**: Knife4j 4.3.0
- **安全认证**: JWT + BCrypt
- **容器化**: Docker Compose

## 📁 项目结构

```
ai-project/
├── sky-takeout-server/     # 后端服务主目录
│   ├── src/main/java/     # Java源代码
│   ├── src/main/resources/ # 配置文件
│   └── pom.xml           # Maven依赖配置
├── db/                    # 数据库相关文件
│   └── schema.sql        # 数据库表结构
├── docs/                  # 项目文档
│   ├── 系统设计/          # 系统架构设计文档
│   ├── 约束规范/          # 开发约束和规范
│   └── 业务模块详细设计/   # 各业务模块详细设计
├── docker-compose.yml     # Docker环境配置
└── README.md             # 项目说明文档
```

## 🛠️ 环境搭建

### 1. 启动基础服务
```bash
# 启动MySQL和Redis
docker-compose up -d
```

### 2. 初始化数据库
```bash
# 导入数据库表结构
docker exec -i sky-mysql mysql -uroot -proot123456 sky_takeout < db/schema.sql
```

### 3. 启动后端服务
```bash
cd sky-takeout-server
mvn spring-boot:run
```

## 📚 文档导航

- [系统设计文档](docs/系统设计/苍穹外卖系统设计文档.md) - 系统整体架构设计
- [约束规范文档](docs/约束规范/约束规范文档.md) - 开发规范和约束
- [业务模块设计](docs/业务模块详细设计/) - 各业务模块详细设计

## 🔧 API文档

服务启动后可通过以下地址访问API文档：

- **Knife4j增强文档**: http://localhost:8080/doc.html
- **Swagger原始界面**: http://localhost:8080/swagger-ui.html

## 🔐 默认登录凭证

```
用户名: admin
密码: admin
```

## 🤝 贡献指南

本项目采用AI主导开发模式，所有代码均由AI生成。如有问题或建议，请提交Issue。

## 📄 许可证

本项目采用 Apache License 2.0 许可证。

---
> **注意**: 本项目为学习和演示目的开发，请勿用于生产环境。