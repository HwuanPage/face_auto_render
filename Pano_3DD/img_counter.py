import os
import click


@click.command()
@click.option('--target_img', 'target_img', help='Target image folder', required=True, metavar='FILE|DIR')
def loop(
    target_img:str,
):
    dir_list= os.listdir(target_img)

    image_count = 0
    for img_name in dir_list:
        _, extension = os.path.splitext(img_name)

        if extension == '.json' or extension=='.pkl':
            continue

        image_count += 1

    string = ''
    for i in range(image_count):
        string += f"{i} "

    print(string)
    # return string

if __name__ == "__main__":
    loop( )
