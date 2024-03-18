import streamlit as st
from minio import Minio
from datetime import datetime
from io import BytesIO
import os

# Minio 서버 정보
minio_host = "localhost:9000"
access_key = "toyDt2pDVZKdp0I7WEXV"
secret_key = "9o4bW2ErV7Drkh7bX2wxZlxfFTE78A5cLXdq4gvr"
bucket_name = "graduationtest"

# Minio 클라이언트 생성
minio_client = Minio(minio_host, access_key=access_key, secret_key=secret_key, secure=False)

# 이미지 업로드 함수
def upload_image_to_minio(file):
    try:
        # 이미지를 Minio 서버에 업로드
        file_name = f"{datetime.now().isoformat().replace(':', '_')}_{file.name}"
        file_data = BytesIO(file.getvalue())
        file_size = len(file_data.getbuffer())
        minio_client.put_object(bucket_name, file_name, file_data, file_size)

        st.success(f"Uploaded File: {file_name} to Minio bucket: {bucket_name}")
    except Exception as e:
        st.error(f"Error uploading file to Minio: {e}")

# Streamlit 애플리케이션
def main():
    st.title("3D 이미지 변환")

    # 이미지 업로드
    uploaded_file = st.file_uploader("이미지를 업로드하세요.", type=['png', 'jpg', 'jpeg'])
    
    if uploaded_file is not None:
        upload_image_to_minio(uploaded_file)
        

# Streamlit 애플리케이션 실행
if __name__ == "__main__":
    main()
