# 基于 LangChain 的带 AI 智能客服的微信小程序商城

个人项目（2026.03 – 2026.05）

独立完成微信小程序、Vue3 管理后台与 FastAPI 后端，实现商品浏览、购物车、地址管理、下单支付，以及基于知识库检索的 AI 客服。

- 基于 LangChain + Chroma 搭建 RAG 流程：知识库文件解析、分块、向量化、Top-K 检索后注入 Prompt，对接阿里云百炼 Qwen，小程序侧按会话保存问答记录
- 管理端支持 txt / doc / pdf / markdown 上传后自动解析并写入向量库，可按文件重新向量化或删除，实现知识库与问答同步更新
- 用户端与管理端共用 JWT，按 `type` 区分身份；下单时校验库存、生成订单号、写入明细并扣减库存，支付后回写销量

**技术栈：** FastAPI、LangChain、Chroma、Vue3、微信小程序、MySQL、JWT、ECharts

管理后台另用 Vite、Pinia、Element Plus；向量检索使用阿里云百炼 Embedding，对话模型为 Qwen。

## 功能

**微信小程序**

- 账号注册 / 登录、个人资料与头像
- 首页轮播、分类浏览、商品详情
- 购物车、地址管理、下单支付、订单列表
- AI 客服：按会话提问，答案来自知识库检索 + 大模型

**管理后台**

- 数据看板（ECharts）：用户数、订单数、销售额，近 7 日趋势、分类占比、订单状态、热销 Top5
- 商品、分类、轮播图、订单、用户管理
- 知识库：上传 txt / doc / pdf / markdown，自动解析并向量化，支持重新向量化与删除

**后端**

- 用户 / 管理员共用 JWT，按 `type` 区分身份
- 下单校验库存、生成订单号、写入明细并扣减库存，支付后回写销量
- RAG：文件解析 → 分块 → 向量化 → Top-K 检索 → 注入 Prompt → Qwen 问答

## 目录

```text
SmartShop/
├── weixin/                 微信小程序
├── client/                 Vue3 管理后台
├── server/                 FastAPI 后端
│   ├── routers/            接口
│   ├── models/             ORM
│   ├── services/           RAG、向量库、文件解析
│   ├── sql/db_ai_shop.sql  建库脚本（含演示数据）
│   └── requirements.txt
├── uploads14/              图片与知识库文件
└── 知识库测试文件/          可直接上传的示例文档
```

## 环境要求

- Python 3.10+
- Node.js 18+
- MySQL 8
- 微信开发者工具
- 阿里云百炼 API Key（只用商城、不测客服时可先不配）

## 启动

### 1. 数据库

修改 `server/config.py` 中的 `DATABASE_URL`，默认：

```text
mysql+pymysql://root:123456@127.0.0.1:3306/db_ai_shop?charset=utf8mb4
```

导入脚本：

```bash
mysql -u root -p < server/sql/db_ai_shop.sql
```

脚本会创建 `db_ai_shop`，并写入管理员、用户、商品等演示数据。

### 2. 后端

```bash
cd server
pip install -r requirements.txt
set OPENAI_API_KEY=你的百炼Key
python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

Linux / macOS 用 `export OPENAI_API_KEY=你的百炼Key`。

启动成功后：

- 接口文档：http://127.0.0.1:8000/docs
- 健康检查：http://127.0.0.1:8000/api/health

模型与向量相关配置在 `server/config.py`：

| 项 | 默认值 |
|---|---|
| 对话模型 | `qwen3.8-max` |
| Embedding | `text-embedding-v4`（2048 维） |
| 分块 | 500 字，重叠 50 |
| 检索 | Top-4 |

向量数据落在 `server/chroma_db/`。上传目录是项目根下的 `uploads14/`。

本机开发只跑管理后台时，`--host 127.0.0.1` 即可。小程序真机联调必须 `--host 0.0.0.0`，否则手机访问不到。

### 3. 管理后台

```bash
cd client
npm install
npm run dev
```

浏览器打开 http://127.0.0.1:5173。Vite 已把 `/api`、`/uploads` 代理到 `http://127.0.0.1:8000`。

演示账号：`admin` / `12345678`

### 4. 微信小程序

用微信开发者工具导入 `weixin/` 目录。

`weixin/utils/request.js` 会按运行环境选主机：

- 开发者工具模拟器 → `http://127.0.0.1:8000/api`
- 真机 → `http://DEVICE_HOST:8000/api`

换网络后只改 `DEVICE_HOST`，填电脑 WLAN 的 IPv4。模拟器不受影响。

演示账号：`user001` / `123456`（也可在小程序里注册）

**真机联调**

1. 手机和电脑同一 Wi-Fi，后端用 `--host 0.0.0.0` 启动
2. 开发者工具勾选「不校验合法域名、web-view、TLS 版本以及 HTTPS 证书」
3. 用「真机调试」，不要用「预览」（预览会强制校验合法域名）
4. 基础库 ≥ 3.8.7 时，真机 `image` 组件不加载 `http` 图片。本地调试可把基础库降到 **3.8.6**
5. 不在同一局域网时，用手机热点或内网穿透，不要指望手机访问你电脑的内网 IP

## RAG 流程

```text
后台上传文档
    → 解析 txt / doc / pdf / markdown
    → 按 500/50 分块
    → Embedding 写入 Chroma
用户提问
    → 相似度检索 Top-4
    → 写入 Prompt
    → Qwen 生成回答
    → 按 session_id 写入 t_chat_message
```

知识库示例文件在 `知识库测试文件/`，管理后台「知识库管理」上传即可。删除或重新向量化会同步更新 Chroma。

## 主要接口

| 模块 | 前缀 | 说明 |
|---|---|---|
| 认证 | `/api/auth` | 管理员登录，用户登录 / 注册 |
| 商品 / 分类 / 轮播 | `/api/product` `/api/category` `/api/banner` | 前台查询 + 后台维护 |
| 购物车 / 地址 / 订单 | `/api/cart` `/api/address` `/api/order` | 用户下单与模拟支付 |
| 客服 | `/api/chat` | 发送消息、会话历史 |
| 知识库 | `/api/knowledge` | 上传、向量化、删除（管理员） |
| 看板 | `/api/dashboard` | 统计数据（管理员） |
| 上传 | `/api/upload` | 图片、头像 |
| 静态文件 | `/uploads` | 商品图、轮播图、头像、知识库文件 |

完整定义见 http://127.0.0.1:8000/docs。

## 说明

- 支付是模拟接口，没有对接微信 / 支付宝
- 登录是账号密码，不是微信 `code` 登录
- RAG 按当前问题检索，历史消息会落库，但不会拼进下一轮 Prompt
- 知识库向量化在上传请求里同步完成
- `OPENAI_API_KEY`、数据库账号不要提交到公开仓库
