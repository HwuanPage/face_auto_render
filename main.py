import streamlit as st
from streamlit_extras.switch_page_button import switch_page

def main():
    st.title("3D 이미지 변환")
        
    st.write("""
        "여러분의 얼굴을 재미있고 특별한 방식으로 표현해보세요. 저희는 2D 안면 이미지를 가져와 약간의 변형을 가하고, 최종적으로는 현실적인 3D 모델로 만들어드립니다.

        당신의 얼굴을 기반으로 만들어진 3D 모델은 STL 형식으로 다운로드 받을 수 있어, 다양한 용도로 활용이 가능합니다. 3D 프린팅, 가상 현실(VR) 애플리케이션 개발 등 여러 분야에서 활용할 수 있습니다. 
        
        여러분의 창의성과 상상력을 펼칠 수 있는 이 독특한 서비스를 경험해보세요. 당신의 얼굴이 어떻게 3D로 변신하는지 지금 바로 확인해보세요!"      
            """)

    if st.button("👉이미지 업로드 하러 가기👈"):
            switch_page("image_upload")
            

if __name__ == "__main__":
    main()