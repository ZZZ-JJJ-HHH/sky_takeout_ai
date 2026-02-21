-- 苍穹外卖数据初始化脚本
-- 说明：用于向已存在的表中插入初始数据
-- 前提：必须先执行 schema.sql 创建表结构

USE sky_takeout;

-- =========================
-- 基础员工数据
-- =========================

-- 管理员账号（密码：admin）
INSERT INTO employee (username, password, name, phone, status, role, create_time, update_time) 
VALUES ('admin', '$2a$10$UOlvEWOqj0kui1xdeLl1uemJ7QCMZPR03.fmLCB9nb9.1GXsLHG22', '系统管理员', '13800138000', 1, 'ADMIN', NOW(), NOW());

-- 普通员工账号（密码：unknow）
INSERT INTO employee (username, password, name, phone, status, role, create_time, update_time) 
VALUES ('employee', '$2a$10$4B5C6D7E8F9G0H1I2J3K4L5M6N7O8P9Q0R1S2T3U4V5W6X7Y8Z9a0b1c2', '张三', '13800138001', 1, 'EMPLOYEE', NOW(), NOW());

-- =========================
-- 基础分类数据
-- =========================

-- 菜品分类
INSERT INTO category (name, type, sort, status, create_time, update_time, create_user, update_user) VALUES
('川菜系列', 1, 1, 1, NOW(), NOW(), 1, 1),
('粤菜系列', 1, 2, 1, NOW(), NOW(), 1, 1),
('湘菜系列', 1, 3, 1, NOW(), NOW(), 1, 1),
('饮品系列', 1, 4, 1, NOW(), NOW(), 1, 1);

-- 套餐分类
INSERT INTO category (name, type, sort, status, create_time, update_time, create_user, update_user) VALUES
('商务套餐', 2, 1, 1, NOW(), NOW(), 1, 1),
('家庭套餐', 2, 2, 1, NOW(), NOW(), 1, 1),
('单人套餐', 2, 3, 1, NOW(), NOW(), 1, 1);

-- =========================
-- 示例菜品数据
-- =========================

INSERT INTO dish (name, category_id, price, image, description, status, sort, create_time, update_time, create_user, update_user) VALUES
('宫保鸡丁', 1, 28.00, '/images/dish/gongbaojiding.jpg', '经典川菜，鸡肉嫩滑，花生香脆', 1, 1, NOW(), NOW(), 1, 1),
('麻婆豆腐', 1, 18.00, '/images/dish/mapodoufu.jpg', '麻辣鲜香，豆腐嫩滑', 1, 2, NOW(), NOW(), 1, 1),
('回锅肉', 1, 32.00, '/images/dish/huigourou.jpg', '肥而不腻，香辣下饭', 1, 3, NOW(), NOW(), 1, 1),
('白切鸡', 2, 35.00, '/images/dish/baiqieji.jpg', '粤式经典，皮爽肉滑', 1, 1, NOW(), NOW(), 1, 1),
('叉烧包', 2, 12.00, '/images/dish/chashaobao.jpg', '广式茶点，香甜可口', 1, 2, NOW(), NOW(), 1, 1),
('剁椒鱼头', 3, 48.00, '/images/dish/duojiaoyutou.jpg', '湘菜代表，鲜辣开胃', 1, 1, NOW(), NOW(), 1, 1);

-- =========================
-- 菜品口味数据
-- =========================

INSERT INTO dish_flavor (dish_id, name, value, create_time, update_time) VALUES
(1, '辣度', '["微辣","中辣","重辣"]', NOW(), NOW()),
(1, '份量', '["小份","中份","大份"]', NOW(), NOW()),
(3, '辣度', '["不辣","微辣","中辣"]', NOW(), NOW()),
(6, '辣度', '["微辣","中辣","重辣","特辣"]', NOW(), NOW());

-- =========================
-- 示例套餐数据
-- =========================

INSERT INTO setmeal (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user) VALUES
('商务午餐套餐A', 5, 38.00, '/images/setmeal/shangwuA.jpg', '宫保鸡丁+白米饭+例汤', 1, NOW(), NOW(), 1, 1),
('家庭欢乐套餐', 6, 88.00, '/images/setmeal/jiating.jpg', '适合3-4人分享的经典组合', 1, NOW(), NOW(), 1, 1),
('单人精选套餐', 7, 25.00, '/images/setmeal/danren.jpg', '麻婆豆腐+米饭+饮品', 1, NOW(), NOW(), 1, 1);

-- =========================
-- 套餐菜品关联
-- =========================

INSERT INTO setmeal_dish (setmeal_id, dish_id, copies, sort) VALUES
(1, 1, 1, 1),  -- 商务套餐包含宫保鸡丁
(1, 4, 1, 2),  -- 商务套餐包含白切鸡
(2, 1, 2, 1),  -- 家庭套餐包含2份宫保鸡丁
(2, 3, 1, 2),  -- 家庭套餐包含回锅肉
(2, 6, 1, 3),  -- 家庭套餐包含剁椒鱼头
(3, 2, 1, 1);  -- 单人套餐包含麻婆豆腐

-- =========================
-- 示例用户数据
-- =========================

INSERT INTO user (phone, nickname, avatar, status, create_time, update_time) VALUES
('13800138002', '李四', '/images/avatar/user1.jpg', 1, NOW(), NOW()),
('13800138003', '王五', '/images/avatar/user2.jpg', 1, NOW(), NOW());

-- =========================
-- 用户地址数据
-- =========================

INSERT INTO address_book (user_id, consignee, phone, province, city, district, detail, label, is_default, create_time, update_time) VALUES
(1, '李四', '13800138002', '北京市', '北京市', '朝阳区', '建国路88号现代城A座1001室', '公司', 1, NOW(), NOW()),
(1, '李四', '13800138002', '北京市', '北京市', '海淀区', '中关村大街1号海龙大厦B座501室', '家', 0, NOW(), NOW()),
(2, '王五', '13800138003', '上海市', '上海市', '浦东新区', '陆家嘴环路1000号环球金融中心', '公司', 1, NOW(), NOW());

-- =========================
-- 系统配置数据
-- =========================

INSERT INTO system_config (config_key, config_value, config_desc, status, create_time, update_time, create_user, update_user) VALUES
('system.name', '苍穹外卖管理系统', '系统名称', 1, NOW(), NOW(), 1, 1),
('system.version', '1.0.0', '系统版本', 1, NOW(), NOW(), 1, 1),
('upload.image.path', '/uploads/images/', '图片上传路径', 1, NOW(), NOW(), 1, 1),
('order.auto_cancel_minutes', '30', '订单自动取消时间（分钟）', 1, NOW(), NOW(), 1, 1),
('business.start_time', '09:00:00', '营业开始时间', 1, NOW(), NOW(), 1, 1),
('business.end_time', '21:00:00', '营业结束时间', 1, NOW(), NOW(), 1, 1);

COMMIT;