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
    st.sidebar.header("Select a demo above.")
    st.write("""
     "여러분의 얼굴을 재미있고 특별한 방식으로 표현해보세요. 저희는 2D 안면 이미지를 가져와 약간의 변형을 가하고, 최종적으로는 현실적인 3D 모델로 만들어드립니다.

    당신의 얼굴을 기반으로 만들어진 3D 모델은 STL 형식으로 다운로드 받을 수 있어, 다양한 용도로 활용이 가능합니다. 3D 프린팅, 가상 현실(VR) 애플리케이션 개발 등 여러 분야에서 활용할 수 있습니다. 
    
    여러분의 창의성과 상상력을 펼칠 수 있는 이 독특한 서비스를 경험해보세요. 당신의 얼굴이 어떻게 3D로 변신하는지 지금 바로 확인해보세요!"      
             """)

    # 이미지 업로드
    uploaded_file = st.file_uploader("이미지를 업로드하세요.", type=['png', 'jpg', 'jpeg'])
    if uploaded_file is not None:
        upload_image_to_minio(uploaded_file)
        

# Streamlit 애플리케이션 실행
if __name__ == "__main__":
    main()
