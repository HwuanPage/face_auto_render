# frontend.py

import streamlit as st
import requests

# FastAPI 백엔드 서버 URL
backend_url = "http://localhost:8000"

# 이미지 업로드 함수
def upload_image_to_backend(file):
    # 이미지를 FastAPI 백엔드에 업로드
    response = requests.post(f"{backend_url}/upload_image", files={"image": file})
    if response.status_code == 200:
        st.success("Image uploaded successfully to backend.")
    else:
        st.error(f"Error uploading image to backend: {response.text}")

# Streamlit 애플리케이션
def main():
    st.title("Streamlit 이미지 업로더")

    # 이미지 업로드
    uploaded_file = st.file_uploader("이미지를 업로드하세요.", type=['png', 'jpg', 'jpeg'])
    if uploaded_file is not None:
        upload_image_to_backend(uploaded_file)

if __name__ == "__main__":
    main()
