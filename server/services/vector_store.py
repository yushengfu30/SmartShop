"""
Chroma向量数据库服务
负责文档向量化存储和相似检索
"""
from typing import List, Optional

from langchain_openai import OpenAIEmbeddings
from langchain_chroma import Chroma
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_core.documents import Document

from config import (
    OPENAI_API_KEY,
    OPENAI_BASE_URL,
    EMBEDDING_MODEL,
    EMBEDDING_DIMENSIONS,
    CHROMA_DIR,
    CHROMA_COLLECTION,
    CHUNK_SIZE,
    CHUNK_OVERLAP,
    RAG_TOP_K,
)


class VectorStoreService:
    """Chroma向量数据库服务类"""

    def __init__(self):
        """初始化嵌入模型和向量存储"""
        self.embeddings = OpenAIEmbeddings(
            model=EMBEDDING_MODEL,
            openai_api_key=OPENAI_API_KEY,
            openai_api_base=OPENAI_BASE_URL,
            dimensions=EMBEDDING_DIMENSIONS,
            # 阿里云兼容接口只接受 str / list[str]，LangChain 默认会发送 token id 数组导致 400
            check_embedding_ctx_length=False,
        )
        self.text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=CHUNK_SIZE,
            chunk_overlap=CHUNK_OVERLAP,
            length_function=len,
        )
        self._vectorstore: Optional[Chroma] = None

    @property
    def vectorstore(self) -> Chroma:
        """
        获取或创建Chroma向量存储实例
        :return: Chroma向量存储
        """
        if self._vectorstore is None:
            self._vectorstore = Chroma(
                collection_name=CHROMA_COLLECTION,
                embedding_function=self.embeddings,
                persist_directory=str(CHROMA_DIR),
            )
        return self._vectorstore

    def add_documents(self, text: str, file_id: int, file_name: str) -> int:
        """
        将文本分块并向量化存入Chroma
        :param text: 文档文本内容
        :param file_id: 知识库文件ID
        :param file_name: 文件名
        :return: 分块数量
        """
        doc = Document(
            page_content=text,
            metadata={"file_id": file_id, "file_name": file_name},
        )
        chunks = self.text_splitter.split_documents([doc])
        if chunks:
            self.vectorstore.add_documents(chunks)
        return len(chunks)

    def delete_by_file_id(self, file_id: int) -> None:
        """
        根据文件ID删除向量数据
        :param file_id: 知识库文件ID
        """
        try:
            self.vectorstore._collection.delete(where={"file_id": file_id})
        except Exception:
            pass

    def similarity_search(self, query: str, top_k: int = RAG_TOP_K) -> List[Document]:
        """
        相似度检索
        :param query: 查询文本
        :param top_k: 返回Top-K结果
        :return: 相关文档列表
        """
        try:
            return self.vectorstore.similarity_search(query, k=top_k)
        except Exception:
            return []


# 全局单例
vector_store_service = VectorStoreService()
