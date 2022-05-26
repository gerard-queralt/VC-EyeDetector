import os
import requests
from PIL import Image
import imagehash
import time
import sys

PATH = "images"
Set = set()
Counter = 0


def initialize_set():
    s = set()
    try:
        with open('hashes.txt') as f:
            lines = f.readlines()
        for line in lines:
            s.add(line)
    except:
        print("It seems it is your first execution, no problem :)")
    finally:
        print("Set initialized to avoid repetitions from previous executions")
    return s


def save_image(picture):
    file = os.path.join(PATH, "auxiliary.jpg")

    with open(file, "wb") as f:  # write byte
        f.write(picture)
    img = Image.open(file)
    hashfile = str(imagehash.average_hash(img))
    if hashfile not in Set:
        Set.add(hashfile)
        img.save(os.path.join(PATH, str(hashfile) + ".jpg"))

        with open('hashes.txt', "a") as f2:  # to append
            f2.write(str(hashfile) + "\n")
        f2.close()

        global Counter
        Counter += 1
        print("Successfully Saved" + " -- Image #: " + str(Counter))

    else:
        print("Already Existed")
    img.close()
    os.remove(file)
    # cerramos y eliminamos aux


def get_image_from_web():
    if eyeImages:
        url = "https://thispersondoesnotexist.com/image"
    else:
        url = "https://picsum.photos/200/300"
    r = requests.get(url).content
    return r


def create_dir():
    try:
        os.mkdir(PATH)
    except OSError:
        print("Creation of the directory %s failed" % PATH)
    else:
        print("Successfully created the directory %s " % PATH)


def objective_reached(num_images):
    global Counter
    return Counter >= num_images


def main(num_dif_images = 0):
    create_dir()
    global Set
    Set = initialize_set()

    if num_dif_images == 0:
        if eyeImages:
            num_dif_images = 300
        else:
            num_dif_images = 400
    while not objective_reached(num_dif_images):
        img = get_image_from_web()
        save_image(img)
        time.sleep(0.5)  # la pagina parece que funciona por tiempo, asi asegura mas imgs diferentes
    return


if __name__ == "__main__":
    eyeImages = True
    if len(sys.argv) > 1:
        secondArg = sys.argv[1]
        if secondArg == "false" or secondArg == "False" or secondArg == "noEyes":
            eyeImages = False
        elif secondArg != "true" and secondArg != "True" and secondArg != "eyes":
            print('Argument ', secondArg, ' not recognised; assuming eye images wanted')
    if len(sys.argv) > 2:
        main(int(sys.argv[2]))
    else:
        main()
