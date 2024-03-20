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
        
        return file_name
    except Exception as e:
        st.error(f"Error uploading file to Minio: {e}")
        
def response_image_from_minio(file_name):
    try:
        # Minio 서버에서 결과 이미지를 가져옴
        data = minio_client.get_object(bucket_name, file_name)
        st.download_button('파일 다운로드', data)
        
        st.success(f"Received result from Minio server: {data}")
    except Exception as e:
        st.error(f"Error getting result from Minio: {e}")
        

# Streamlit 애플리케이션
def main():
    st.title("3D 이미지 변환")

    # 이미지 업로드
    uploaded_file = st.file_uploader("이미지를 업로드하세요.", type=['png', 'jpg', 'jpeg'])
    
    if uploaded_file is not None:
        file_name = upload_image_to_minio(uploaded_file)
        # 결과 파일이 존재 한다면 결과 이미지 출력
        if minio_client.bucket_exists(bucket_name) and minio_client.stat_object(bucket_name, file_name):
            st.write("이미지가 변환되었습니다...")
            response_image_from_minio(file_name)
        else:
            st.write("이미지를 변환하고 있습니다...")
        
# Streamlit 애플리케이션 실행
if __name__ == "__main__":
    main()
