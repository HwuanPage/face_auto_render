import streamlit as st
from datetime import datetime
import os
from PIL import Image,ImageDraw,ImageFont
def save_uploadedfile(directory,file):  # 이미지 업로드 함수
    if not os.path.exists(directory):
        os.makedirs(directory)
    with open(os.path.join(directory,file.name),'wb') as f:
        f.write(file.getbuffer())
        return st.success("Saved File:{} in uploads".format(file.name))
def add_watermark(image_path, watermark_text,output_path):
    photo = Image.open(image_path)
    width, height = photo.size
    drawing = ImageDraw.Draw(photo)
    black = (255, 255, 255)  # color of the text
    font = ImageFont.truetype("arial.ttf", 40)
    drawing.text((photo.width/2, photo.height/2), watermark_text, fill=black, font=font)
    photo.save(output_path)
menu =['이미지 업로드','사용자 정보','credit']
choice = st.sidebar.selectbox('메뉴',menu)
img = st.file_uploader('이미지 업로드', type=['png','jpg','jpeg'])
if img is not None:
    current_time = datetime.now()
    filename = current_time.isoformat().replace(':','_')
    img_file_name=filename
    save_uploadedfile('images',img)
    uploaded_image_path = os.path.join('images',img.name)
    watermark_text ="your destiny is gonna be 3d printed"
    output_image_path = os.path.join('images',img_file_name+'_watermarked.jpg')
    add_watermark(uploaded_image_path,watermark_text,output_image_path)
    st.image(output_image_path,caption='워터마크가 추가된 이미지',use_column_width=True)