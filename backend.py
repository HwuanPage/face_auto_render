# backend.py

from fastapi import FastAPI, File, UploadFile
from minio import Minio
from io import BytesIO

app = FastAPI()

# MinIO 서버 정보
minio_host = "localhost:9000"
access_key = "toyDt2pDVZKdp0I7WEXV"
secret_key = "9o4bW2ErV7Drkh7bX2wxZlxfFTE78A5cLXdq4gvr"
bucket_name = "graduationtest"

# MinIO 클라이언트 생성
minio_client = Minio(minio_host, access_key=access_key, secret_key=secret_key, secure=False)

# 이미지 업로드 엔드포인트
@app.post("/upload_image")
async def upload_image(image: UploadFile = File(...)):
    try:
        # 이미지를 MinIO 서버에 업로드
        file_data = await image.read()
        image_name = f"{image.filename}"
        minio_client.put_object(bucket_name, image_name, BytesIO(file_data), len(file_data))
        return {"message": "Image uploaded successfully"}
    except Exception as e:
        return {"error": f"Error uploading image to Minio: {e}"}
