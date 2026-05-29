# 秒杀商城（Seckill Mall）

基于 Spring Boot + Redis + RabbitMQ 的高并发电商秒杀系统，集成 AI 智能客服模块。

## 技术栈

- **后端框架**：Spring Boot、Spring Cloud Alibaba
- **高并发**：Redis（Lua原子扣减/分布式锁）、RabbitMQ（异步削峰）、Sentinel（限流降级）
- **AI工程化**：DeepSeek API、RAG检索增强生成、SSE流式输出、Spring WebFlux
- **数据存储**：MySQL、Redis
- **前端**：原生 HTML/CSS/JS

## 核心功能

| 模块 | 技术亮点 |
|------|---------|
| 秒杀核心 | Redis+Lua原子扣减、Redisson分布式锁、零超卖 |
| 订单系统 | RabbitMQ异步创建、15分钟延迟取消、吞吐量提升300% |
| AI智能客服 | RAG知识库问答（Redis检索+Prompt注入）、SSE流式输出、三级缓存成本控制 |
| 稳定性 | Sentinel限流、异常分级降级、接口响应50ms |

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