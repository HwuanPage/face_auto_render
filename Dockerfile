# Docker 이미지의 베이스 이미지를 설정합니다.
FROM python:3.12.0

# 필요한 라이브러리를 설치합니다.
RUN pip install streamlit pillow

# 작업 디렉토리를 설정합니다.
WORKDIR /app

# 현재 디렉토리에 있는 모든 파일을 Docker 이미지의 /app 디렉토리로 복사합니다.
COPY . /app

# 컨테이너가 실행될 때 사용할 명령을 지정합니다.
CMD ["streamlit", "run", "example.py", "--server.port", "8501"]
