"""
项目配置文件
基于LangChain的带AI智能客服的微信小程序商城系统
"""
import os
from pathlib import Path

# 项目根目录
BASE_DIR = Path(__file__).resolve().parent

# 数据库配置 MySQL8 端口3306
DATABASE_URL = "mysql+pymysql://root:123456@127.0.0.1:3306/db_ai_shop?charset=utf8mb4"

# JWT配置
SECRET_KEY = "ai-shop-secret-key-2026-langchain-rag"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_HOURS = 24

# 文件上传目录：项目根目录下的 uploads14
UPLOAD_DIR = BASE_DIR.parent / "uploads14"
UPLOAD_DIR.mkdir(parents=True, exist_ok=True)

# 知识库文件子目录
KNOWLEDGE_DIR = UPLOAD_DIR / "knowledge"
KNOWLEDGE_DIR.mkdir(parents=True, exist_ok=True)

# 商品图片子目录
PRODUCT_DIR = UPLOAD_DIR / "product"
PRODUCT_DIR.mkdir(parents=True, exist_ok=True)

# 轮播图子目录
BANNER_DIR = UPLOAD_DIR / "banner"
BANNER_DIR.mkdir(parents=True, exist_ok=True)

# 头像子目录
AVATAR_DIR = UPLOAD_DIR / "avatar"
AVATAR_DIR.mkdir(parents=True, exist_ok=True)

# Chroma向量数据库持久化目录
CHROMA_DIR = BASE_DIR / "chroma_db"
CHROMA_DIR.mkdir(parents=True, exist_ok=True)

# OpenAI兼容接口配置(阿里云MaaS)
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY", "")
OPENAI_BASE_URL = "https://ws-gdjabdxi8ehn33fh.cn-beijing.maas.aliyuncs.com/compatible-mode/v1"
CHAT_MODEL = "qwen3.8-max"
EMBEDDING_MODEL = "text-embedding-v4"
EMBEDDING_DIMENSIONS = 2048

# Chroma集合名称
CHROMA_COLLECTION = "ai_shop_knowledge"

# RAG检索Top-K
RAG_TOP_K = 4

# 文本分块配置
CHUNK_SIZE = 500
CHUNK_OVERLAP = 50

# 项目名称
PROJECT_NAME = "基于LangChain的带AI智能客服的微信小程序商城系统"
