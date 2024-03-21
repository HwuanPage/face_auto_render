from dlib_func import dlib_kps
from projector_func import *
from recrop_func import *
from nst import *
import os
import click

class ImageTo3D:

    def spot_face_feature(self, image_dir):
        dlib_kps(image_dir)

    def crop_images(self, image_dir:str, crop_dir_path:str, size:int):
        ff_path = os.path.join(image_dir, 'face_feature.pkl')

        recrop_images(
            face_feature_path=ff_path,
            out_dir = crop_dir_path,
            size = size
        )

    def style_transfer(self, crop_image_dir, style_type, steps:int=300,image_size:int=1024):

        content_path = {
            0:'./contents_images/Leonardo_da_Vinci_121.jpg',
            1:'./contents_images/Rembrandt_75.jpg',
            2:'./contents_images/Vincent_van_Gogh_84.jpg',
            3:'./contents_images/Vincent_van_Gogh_93.jpg',
            4:'./contents_images/Vincent_van_Gogh_95.jpg',
            5:'./contents_images/Vincent_van_Gogh_837.jpg',
        }

        # load images
        list_dir = os.listdir(crop_image_dir)

        for img_name in list_dir:
            _, extension = os.path.splitext(img_name)

            if extension == '.json' or extension=='.pkl':
                continue

            output_path = os.path.join(crop_image_dir, img_name)
            img_path = os.path.join(crop_image_dir, img_name)
            
            neural_transform_main(img_path, content_path[style_type] , output_path ,steps=steps,img_size=image_size)

        print('Style Transform Done!')

    def build_3d(
        self,
        pano_wight_path:str,
        crop_dir_path:str,
        outdir_path:str,
        proj_steps:int,
        pti_steps:int,
        extension,
        ):

        dir_list = os.listdir(crop_dir_path)

        image_count = 0
        for img_name in dir_list:
            _, ext = os.path.splitext(img_name)

            if ext == '.json' or ext=='.pkl':
                continue

            image_count += 1
        for i in range(image_count):
            
            index = (i+1)%4
            print(f"cuda index:{index}")
            
            run_projection(
                network_pkl = pano_wight_path,
                target_img = crop_dir_path,
                outdir = outdir_path,
                idx = i,
                num_steps = proj_steps,
                num_steps_pti = pti_steps,
                extension = extension,
                device = torch.device('cuda',index)
            )


@click.command()
@click.option('--image_dir', 'image_dir', type=str,  required=True)
@click.option('--crop_dir', help='cropped image save directory', type=str,  required=True)
@click.option('--out_dir_path', help='rendered 3d file save directory',type=str,  required=True)
@click.option('--weight_path', help='PanoHead weight path', type=str, required=True)
@click.option('--projection_steps', 'steps_proj', type=int, default=100 ,help='how many projections')
@click.option('--pti_steps', 'steps_pti', type=int, default=100 ,help='how many fine tune 3d')
@click.option('--extension' ,help='output file extension', type=click.Choice(['.mrc', '.ply', '.stl']), default='.ply')
@click.option('--image_size', 'size',type=int, default=1024)
@click.option('--style_transform' ,type=bool, default=False)
@click.option('--style_type' ,type=int, default=0)
def flow_run(
    image_dir:str,
    crop_dir:str,
    out_dir_path:str,
    weight_path:str,
    steps_proj:int,
    steps_pti:int,
    extension:str,
    size:int,
    style_transform:bool,
    style_type:int
):

    # class 선언 Image ro Rendering
    I2R = ImageTo3D()

    I2R.spot_face_feature(image_dir)

    I2R.crop_images(image_dir, crop_dir, size)

    if style_transform:
        I2R.style_transfer(crop_dir, style_type,steps = steps_proj*2)

    I2R.build_3d(outdir_path = out_dir_path,
                 crop_dir_path = crop_dir,
                 pano_wight_path = weight_path,
                 proj_steps = steps_proj,
                 pti_steps = steps_pti,
                 extension = extension
                 )


if __name__=="__main__":
    flow_run()

