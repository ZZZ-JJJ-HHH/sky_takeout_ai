-- 苍穹外卖（AI 重构版）核心数据库结构
-- 说明：
-- 1. 默认使用 MySQL 8.x，字符集统一为 utf8mb4
-- 2. 表名、字段名采用下划线风格，实体类使用驼峰映射
-- 3. 先创建核心业务表，后续可按需补充索引与约束

CREATE DATABASE IF NOT EXISTS sky_takeout
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE sky_takeout;

-- =========================
-- 员工与用户相关
-- =========================

-- 后台员工表
CREATE TABLE IF NOT EXISTS employee (
  id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
  username     VARCHAR(64) NOT NULL COMMENT '登录用户名（唯一）',
  password     VARCHAR(128) NOT NULL COMMENT '登录密码（BCrypt 加密）',
  name         VARCHAR(64) NOT NULL COMMENT '员工姓名',
  phone        VARCHAR(20) DEFAULT NULL COMMENT '手机号',
  status       TINYINT     NOT NULL DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
  role         VARCHAR(32) NOT NULL DEFAULT 'EMPLOYEE' COMMENT '角色：ADMIN/EMPLOYEE 等',
  create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  create_user  BIGINT      DEFAULT NULL COMMENT '创建人 ID',
  update_user  BIGINT      DEFAULT NULL COMMENT '更新人 ID',
  PRIMARY KEY (id),
  UNIQUE KEY uk_employee_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台员工表';

-- C 端用户表
CREATE TABLE IF NOT EXISTS user (
  id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
  phone        VARCHAR(20) NOT NULL COMMENT '手机号（唯一）',
  nickname     VARCHAR(64) DEFAULT NULL COMMENT '昵称',
  avatar       VARCHAR(255) DEFAULT NULL COMMENT '头像地址',
  status       TINYINT     NOT NULL DEFAULT 1 COMMENT '状态：1-正常，0-禁用',
  create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_user_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='C 端用户表';

-- 用户地址簿
CREATE TABLE IF NOT EXISTS address_book (
  id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
  user_id      BIGINT      NOT NULL COMMENT '用户 ID',
  consignee    VARCHAR(64) NOT NULL COMMENT '收货人',
  phone        VARCHAR(20) NOT NULL COMMENT '联系电话',
  province     VARCHAR(64) DEFAULT NULL COMMENT '省',
  city         VARCHAR(64) DEFAULT NULL COMMENT '市',
  district     VARCHAR(64) DEFAULT NULL COMMENT '区/县',
  detail       VARCHAR(255) NOT NULL COMMENT '详细地址',
  label        VARCHAR(32) DEFAULT NULL COMMENT '标签（公司/家/学校等）',
  is_default   TINYINT     NOT NULL DEFAULT 0 COMMENT '是否默认地址：1-是，0-否',
  create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_address_user_id (user_id),
  CONSTRAINT fk_address_user_id FOREIGN KEY (user_id) REFERENCES user (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户地址簿';

-- =========================
-- 商品相关：分类、菜品、套餐
-- =========================

-- 分类表（菜品/套餐）
CREATE TABLE IF NOT EXISTS category (
  id           BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
  name         VARCHAR(64) NOT NULL COMMENT '分类名称',
  type         TINYINT     NOT NULL COMMENT '分类类型：1-菜品分类，2-套餐分类',
  sort         INT         NOT NULL DEFAULT 0 COMMENT '顺序',
  status       TINYINT     NOT NULL DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
  create_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  create_user  BIGINT      DEFAULT NULL COMMENT '创建人 ID',
  update_user  BIGINT      DEFAULT NULL COMMENT '更新人 ID',
  PRIMARY KEY (id),
  UNIQUE KEY uk_category_name_type (name, type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜品及套餐分类';

-- 菜品表
CREATE TABLE IF NOT EXISTS dish (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  name         VARCHAR(128) NOT NULL COMMENT '菜品名称',
  category_id  BIGINT       NOT NULL COMMENT '分类 ID',
  price        DECIMAL(10,2) NOT NULL COMMENT '价格',
  image        VARCHAR(255) DEFAULT NULL COMMENT '图片地址',
  description  VARCHAR(512) DEFAULT NULL COMMENT '描述信息',
  status       TINYINT      NOT NULL DEFAULT 1 COMMENT '状态：1-在售，0-停售',
  sort         INT          NOT NULL DEFAULT 0 COMMENT '排序',
  create_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  create_user  BIGINT       DEFAULT NULL COMMENT '创建人 ID',
  update_user  BIGINT       DEFAULT NULL COMMENT '更新人 ID',
  PRIMARY KEY (id),
  KEY idx_dish_category_id (category_id),
  CONSTRAINT fk_dish_category_id FOREIGN KEY (category_id) REFERENCES category (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜品表';

-- 菜品口味表
CREATE TABLE IF NOT EXISTS dish_flavor (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  dish_id      BIGINT       NOT NULL COMMENT '菜品 ID',
  name         VARCHAR(64)  NOT NULL COMMENT '口味名称，如 辣度',
  value        VARCHAR(255) NOT NULL COMMENT '口味值列表，JSON 格式存储',
  create_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_flavor_dish_id (dish_id),
  CONSTRAINT fk_flavor_dish_id FOREIGN KEY (dish_id) REFERENCES dish (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜品口味表';

-- 套餐表
CREATE TABLE IF NOT EXISTS setmeal (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  name         VARCHAR(128) NOT NULL COMMENT '套餐名称',
  category_id  BIGINT       NOT NULL COMMENT '分类 ID',
  price        DECIMAL(10,2) NOT NULL COMMENT '套餐价格',
  image        VARCHAR(255) DEFAULT NULL COMMENT '图片地址',
  description  VARCHAR(512) DEFAULT NULL COMMENT '描述信息',
  status       TINYINT      NOT NULL DEFAULT 1 COMMENT '状态：1-在售，0-停售',
  create_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  create_user  BIGINT       DEFAULT NULL COMMENT '创建人 ID',
  update_user  BIGINT       DEFAULT NULL COMMENT '更新人 ID',
  PRIMARY KEY (id),
  KEY idx_setmeal_category_id (category_id),
  CONSTRAINT fk_setmeal_category_id FOREIGN KEY (category_id) REFERENCES category (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='套餐表';

-- 套餐与菜品关联表
CREATE TABLE IF NOT EXISTS setmeal_dish (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  setmeal_id   BIGINT       NOT NULL COMMENT '套餐 ID',
  dish_id      BIGINT       NOT NULL COMMENT '菜品 ID',
  copies       INT          NOT NULL DEFAULT 1 COMMENT '份数',
  sort         INT          NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (id),
  KEY idx_setmeal_dish_setmeal_id (setmeal_id),
  KEY idx_setmeal_dish_dish_id (dish_id),
  CONSTRAINT fk_setmeal_dish_setmeal_id FOREIGN KEY (setmeal_id) REFERENCES setmeal (id) ON DELETE CASCADE,
  CONSTRAINT fk_setmeal_dish_dish_id FOREIGN KEY (dish_id) REFERENCES dish (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='套餐菜品关联表';

-- =========================
-- 购物车与订单相关
-- =========================

-- 购物车（可选：后续迁移到 Redis，仅保留结构）
CREATE TABLE IF NOT EXISTS shopping_cart (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  user_id      BIGINT       NOT NULL COMMENT '用户 ID',
  dish_id      BIGINT       DEFAULT NULL COMMENT '菜品 ID',
  setmeal_id   BIGINT       DEFAULT NULL COMMENT '套餐 ID',
  dish_flavor  VARCHAR(255) DEFAULT NULL COMMENT '口味，JSON 或字符串',
  number       INT          NOT NULL DEFAULT 1 COMMENT '数量',
  amount       DECIMAL(10,2) NOT NULL COMMENT '金额',
  create_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY idx_cart_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- 订单主表
CREATE TABLE IF NOT EXISTS orders (
  id             BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  order_number   VARCHAR(64)  NOT NULL COMMENT '订单号',
  user_id        BIGINT       NOT NULL COMMENT '用户 ID',
  address_book_id BIGINT      NOT NULL COMMENT '地址簿 ID',
  amount         DECIMAL(10,2) NOT NULL COMMENT '订单金额',
  status         TINYINT      NOT NULL COMMENT '订单状态：1-待支付，2-待接单，3-制作中，4-派送中，5-已完成，6-已取消',
  pay_status     TINYINT      NOT NULL DEFAULT 0 COMMENT '支付状态：0-未支付，1-已支付，2-退款',
  pay_method     TINYINT      NOT NULL DEFAULT 1 COMMENT '支付方式：1-模拟支付',
  remark         VARCHAR(255) DEFAULT NULL COMMENT '备注',
  cancel_reason  VARCHAR(255) DEFAULT NULL COMMENT '取消原因',
  order_time     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  checkout_time  DATETIME     DEFAULT NULL COMMENT '支付/结账时间',
  phone          VARCHAR(20)  NOT NULL COMMENT '联系电话（冗余）',
  consignee      VARCHAR(64)  NOT NULL COMMENT '收货人（冗余）',
  address        VARCHAR(255) NOT NULL COMMENT '收货地址（冗余）',
  PRIMARY KEY (id),
  UNIQUE KEY uk_orders_order_number (order_number),
  KEY idx_orders_user_id (user_id),
  KEY idx_orders_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单明细表
CREATE TABLE IF NOT EXISTS order_detail (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  order_id     BIGINT       NOT NULL COMMENT '订单 ID',
  dish_id      BIGINT       DEFAULT NULL COMMENT '菜品 ID',
  setmeal_id   BIGINT       DEFAULT NULL COMMENT '套餐 ID',
  name         VARCHAR(128) NOT NULL COMMENT '菜品/套餐名称',
  image        VARCHAR(255) DEFAULT NULL COMMENT '图片',
  dish_flavor  VARCHAR(255) DEFAULT NULL COMMENT '口味',
  number       INT          NOT NULL DEFAULT 1 COMMENT '数量',
  amount       DECIMAL(10,2) NOT NULL COMMENT '金额',
  PRIMARY KEY (id),
  KEY idx_order_detail_order_id (order_id),
  CONSTRAINT fk_order_detail_order_id FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细表';

-- =========================
-- 运营与统计相关
-- =========================

-- 用户反馈/评价表
CREATE TABLE IF NOT EXISTS user_feedback (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  order_id     BIGINT       NOT NULL COMMENT '订单 ID',
  user_id      BIGINT       NOT NULL COMMENT '用户 ID',
  score        TINYINT      NOT NULL COMMENT '评分：1-5星',
  content      VARCHAR(512) DEFAULT NULL COMMENT '评价内容',
  image_urls   TEXT         DEFAULT NULL COMMENT '评价图片URL，JSON数组',
  status       TINYINT      NOT NULL DEFAULT 1 COMMENT '状态：1-显示，0-隐藏',
  create_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_feedback_order_id (order_id),
  KEY idx_feedback_user_id (user_id),
  CONSTRAINT fk_feedback_order_id FOREIGN KEY (order_id) REFERENCES orders (id),
  CONSTRAINT fk_feedback_user_id FOREIGN KEY (user_id) REFERENCES user (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户评价表';

-- 系统配置表
CREATE TABLE IF NOT EXISTS system_config (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  config_key   VARCHAR(128) NOT NULL COMMENT '配置键',
  config_value TEXT         NOT NULL COMMENT '配置值',
  config_desc  VARCHAR(255) DEFAULT NULL COMMENT '配置描述',
  status       TINYINT      NOT NULL DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
  create_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  create_user  BIGINT       DEFAULT NULL COMMENT '创建人 ID',
  update_user  BIGINT       DEFAULT NULL COMMENT '更新人 ID',
  PRIMARY KEY (id),
  UNIQUE KEY uk_config_key (config_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- 操作日志表
CREATE TABLE IF NOT EXISTS operation_log (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  employee_id  BIGINT       DEFAULT NULL COMMENT '操作员工 ID',
  operation    VARCHAR(128) NOT NULL COMMENT '操作类型：LOGIN/LOGOUT/CREATE/UPDATE/DELETE等',
  module       VARCHAR(64)  NOT NULL COMMENT '操作模块：员工管理/菜品管理/订单管理等',
  description  VARCHAR(255) NOT NULL COMMENT '操作描述',
  request_url  VARCHAR(255) DEFAULT NULL COMMENT '请求URL',
  request_method VARCHAR(16) DEFAULT NULL COMMENT '请求方法',
  request_params TEXT         DEFAULT NULL COMMENT '请求参数',
  ip_address   VARCHAR(64)  DEFAULT NULL COMMENT 'IP地址',
  user_agent   VARCHAR(512) DEFAULT NULL COMMENT '用户代理',
  status       TINYINT      NOT NULL COMMENT '操作状态：1-成功，0-失败',
  error_msg    TEXT         DEFAULT NULL COMMENT '错误信息',
  duration     INT          DEFAULT NULL COMMENT '执行耗时（毫秒）',
  create_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (id),
  KEY idx_log_employee_id (employee_id),
  KEY idx_log_create_time (create_time),
  KEY idx_log_operation (operation)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表';

-- 支付记录（模拟）
CREATE TABLE IF NOT EXISTS payment_record (
  id           BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
  order_id     BIGINT       NOT NULL COMMENT '订单 ID',
  pay_amount   DECIMAL(10,2) NOT NULL COMMENT '支付金额',
  pay_status   TINYINT      NOT NULL COMMENT '支付状态：0-未支付，1-成功，2-失败',
  pay_method   TINYINT      NOT NULL DEFAULT 1 COMMENT '支付方式：1-模拟支付',
  transaction_no VARCHAR(128) DEFAULT NULL COMMENT '交易流水号',
  pay_time     DATETIME     DEFAULT NULL COMMENT '支付时间',
  create_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY uk_payment_transaction_no (transaction_no),
  KEY idx_payment_order_id (order_id),
  KEY idx_payment_pay_time (pay_time),
  CONSTRAINT fk_payment_order_id FOREIGN KEY (order_id) REFERENCES orders (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付记录表';

