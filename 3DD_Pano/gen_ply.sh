
model="easy.pkl"
in="./models"
out="pti_out"


python projector_withseg_opt.py --outdir=${out} --target_img=dataset/testdata_img --network ./Pano_weights/${model}
