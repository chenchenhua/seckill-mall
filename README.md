# 秒杀商城（Seckill Mall）

基于 Spring Boot + Redis + RabbitMQ 的高并发电商秒杀系统，集成 AI 智能客服模块。

## 技术栈

| 层级 | 技术 |
|------|------|
| 后端框架 | Spring Boot 2.x、Spring Cloud Alibaba |
| 高并发 | Redis（Lua原子扣减/分布式锁）、RabbitMQ（异步削峰）、Sentinel（限流降级） |
| AI工程化 | DeepSeek API、RAG检索增强生成、SSE流式输出、Spring WebFlux |
| 数据存储 | MySQL 8.0、Redis 6.x |
| 前端 | 原生 HTML5 / CSS3 / JavaScript |
| 部署 | Docker、Linux、Nginx |

## 核心功能

| 模块 | 技术亮点 |
|------|---------|
| 秒杀核心 | Redis+Lua原子扣减库存、Redisson分布式锁、零超卖 |
| 订单系统 | RabbitMQ异步创建、15分钟延迟取消、吞吐量提升300% |
| AI智能客服 | RAG知识库问答（Redis检索+Prompt注入）、SSE流式输出、多级缓存成本控制 |
| 用户系统 | JWT无状态认证、登录拦截器、Session管理 |
| 稳定性 | Sentinel限流降级、全局异常处理、接口响应50ms |

## 项目结构
src/main/java/com/seckill/
├── config/          # 配置类（Redis、MQ、AI等）
├── controller/      # 控制器
├── service/         # 业务逻辑（含AI模块）
├── dto/             # 数据传输对象
├── util/            # 工具类
└── ...

## 快速启动

1. 配置 `application.yml` 中的数据库、Redis、RabbitMQ、DeepSeek API Key
2. 启动 `SeckillMall1Application`
3. 访问 `http://localhost:8080`

## AI客服演示

- 商品详情页右下角浮窗，支持拖动
- 基于当前商品ID自动注入上下文（RAG）
- SSE流式输出，逐字呈现回复

---
| 组件       | 版本   | 说明       |
| -------- | ---- | -------- |
| JDK      | 1.8+ | Java开发环境 |
| MySQL    | 8.0+ | 数据库      |
| Redis    | 6.x+ | 缓存、分布式锁  |
| RabbitMQ | 3.x+ | 消息队列     |
| Maven    | 3.6+ | 构建工具     |

快速启动
1. 克隆项目
   bash
   git clone https://github.com/chenchenhua/seckill-mall.git
   cd seckill-mall
2. 初始化数据库
   bash
# 登录MySQL，执行上面的建表SQL
3. 配置本地环境
   复制 application-dev.yml（本地开发配置，不提交Git）：
   yaml
# src/main/resources/application-dev.yml
4. 启动服务
   bash
   mvn clean package
   java -jar target/seckill-mall-1.0-SNAPSHOT.jar --spring.profiles.active=dev
5. 访问系统
   首页：http://localhost:8080
   商品详情：http://localhost:8080/src/pages/seckill-detail/seckill-detail.html?id=1
   AI客服浮窗：右下角拖动按钮