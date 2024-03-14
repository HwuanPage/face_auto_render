model="./Pano_weights/easy.pkl"
origin_images="dataset/testdata_img"
crop_out="crop_samples"
rendering_out="rendering_samples"
steps=25
steps_pti=25

python pano_3dd_compose.py \
            --image_dir=${origin_images} --crop_dir=${crop_out} \
            --out_dir_path=${rendering_out} --weight_path=${model} \
            --projection_steps=${steps} --pti_steps=${steps_pti} \
            --style_transform=True --style_type=1
