-- ======================
-- 秒杀项目数据库（前后端完全匹配）
-- ======================
CREATE DATABASE IF NOT EXISTS seckill_db DEFAULT CHARSET utf8mb4;
USE seckill_db;

-- ----------------------
-- 1. 用户表（前端登录注册）
-- ----------------------
CREATE TABLE user (
                      id BIGINT PRIMARY KEY AUTO_INCREMENT,
                      username VARCHAR(50) NOT NULL UNIQUE,
                      password VARCHAR(100) NOT NULL,
                      phone VARCHAR(20),
                      create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                      update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------
-- 2. 商品表（前端商品列表）
-- ----------------------
CREATE TABLE `seckill_goods` (
                                 `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                 `seckill_goods_name` varchar(255) NOT NULL COMMENT '秒杀商品名称',
                                 `origin_price` decimal(10,2) NOT NULL COMMENT '商品原价',
                                 `seckill_price` decimal(10,2) NOT NULL COMMENT '秒杀活动价',
                                 `stock_count` int NOT NULL DEFAULT 0 COMMENT '秒杀总库存',
                                 `limit_num` int NOT NULL DEFAULT 1 COMMENT '单人限购数量',
                                 `images` varchar(500) DEFAULT NULL COMMENT '商品图片',
                                 `goods_desc` varchar(1000) DEFAULT NULL COMMENT '商品详情描述',
                                 `start_time` datetime DEFAULT NULL COMMENT '秒杀开始时间',
                                 `end_time` datetime DEFAULT NULL COMMENT '秒杀结束时间',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='秒杀商品表';
-- ----------------------
-- 4. 订单表（前端我的订单）
-- ----------------------
CREATE TABLE order_info (
                            id BIGINT PRIMARY KEY AUTO_INCREMENT,
                            user_id BIGINT NOT NULL,
                            goods_id BIGINT NOT NULL,
                            seckill_goods_id BIGINT,
                            goods_name VARCHAR(100),
                            goods_price DECIMAL(10,2),
                            order_num INT DEFAULT 1,
                            order_price DECIMAL(10,2),
                            order_status TINYINT DEFAULT 0 COMMENT '0未支付 1已支付 2已发货 3已收货 4已取消',
                            create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                            pay_time DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- ----------------------
-- 5. 秒杀订单表（防止重复秒杀）
-- ----------------------
CREATE TABLE seckill_order (
                               id BIGINT PRIMARY KEY AUTO_INCREMENT,
                               user_id BIGINT NOT NULL,
                               order_id BIGINT NOT NULL,
                               goods_id BIGINT NOT NULL,
                               UNIQUE KEY idx_user_goods (user_id, goods_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='秒杀订单表';

-- ----------------------
-- 6. 库存表（秒杀库存）
-- ----------------------
CREATE TABLE stock (
                       id BIGINT PRIMARY KEY AUTO_INCREMENT,
                       goods_id BIGINT NOT NULL UNIQUE,
                       stock_count INT NOT NULL DEFAULT 0,
                       lock_count INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存表';

ALTER TABLE user ADD COLUMN role TINYINT NOT NULL DEFAULT 1 COMMENT '用户角色：1普通用户 2管理员';

-- 给 user 表添加 salt 字段（密码加密盐值）
ALTER TABLE `user`
    ADD COLUMN `salt` varchar(32) DEFAULT NULL COMMENT '密码加密盐值'
        AFTER `password`;

ALTER TABLE order_info
    CHANGE COLUMN order_num order_no VARCHAR(64) NOT NULL,
    ADD UNIQUE KEY uk_order_no (order_no);

ALTER TABLE order_info
    ADD COLUMN expire_time DATETIME NULL AFTER pay_time;

INSERT INTO seckill_goods (seckill_goods_name, origin_price, seckill_price, stock_count, limit_num, images, goods_desc, start_time, end_time)
VALUES
    ('秒杀旗舰手机', 3999.00, 1999.00, 100, 1, 'https://picsum.photos/300/200?random=1', '年度旗舰手机，限时半价秒杀', NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY)),
    ('无线蓝牙耳机', 299.00, 99.00, 200, 2, 'https://picsum.photos/300/200?random=2', '主动降噪蓝牙耳机，音质超棒', NOW(), DATE_ADD(NOW(), INTERVAL 12 HOUR));

ALTER TABLE seckill_goods
    ADD COLUMN preheat_time DATETIME NULL COMMENT '预热开始时间' AFTER goods_desc;