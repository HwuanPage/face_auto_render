model="easy.pkl"
origin_images="dataset/testdata_img"
crop_out="crop_samples"
rendering_out="rendering_samples"

python dlib_kps_revised.py --target_img=${origin_images}

face_feature=${origin_images}/face_feature.pkl

python recrop_images_revised.py --ffpath=${face_feature} --out_dir=${crop_out}

loop=`python img_counter.py --target_img=${crop_out}`

for i in ${loop}
do
    echo ${i}
    python projector_withseg_opt.py --outdir=${rendering_out} --target_img=${crop_out} --network ./Pano_weights/${model} --idx=${i}
done