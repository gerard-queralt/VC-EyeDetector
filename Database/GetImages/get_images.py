import os
import requests
from PIL import Image
import imagehash
import time

PATH = "images/"
Set=set()
Counter = 0

def initializeSet():
    s=set()
    try:
        with open('hashes.txt') as f:
            lines = f.readlines()
        for line in lines:
            s.add(line)
    except :
        print("It seems it is your first execution, no problem :)")
    finally:
        print("Set inicialized to avoid repetitions from previous executions")
    return s


def save_image(picture):
    file = PATH + "aux.jpg"

    with open(file, "wb") as f: # wrtie byte
        f.write(picture)
    img = Image.open(file)
    Hashfile = str(imagehash.average_hash(img))
    if Hashfile not in Set:
        Set.add(Hashfile)
        img.save( PATH + str(Hashfile) + ".jpg")

        with open('hashes.txt',"a") as f2: # to append
            f2.write(str(Hashfile) + "\n")
        f2.close()

        global Counter
        Counter += 1
        print("Succesfully Saved" + " -- Image #: " + str(Counter) )

    else:
        print("Already Existed")
    img.close()
    os.remove(file)
    # cerramos y eliminamos aux


def get_image_from_web():
    r = requests.get("https://thispersondoesnotexist.com/image").content
    return r


def create_dir():
    try:
        os.mkdir(PATH)
    except OSError:
        print ("Creation of the directory %s failed" % PATH)
    else:
        print ("Successfully created the directory %s " % PATH)

def objectiveReached(NumImages):
    global Counter
    return Counter >= NumImages

def main():
    create_dir()
    global Set
    Set = initializeSet()

    NumDifImages = 300
    while not objectiveReached(NumDifImages):
        img = get_image_from_web()
        save_image(img)
        time.sleep(0.5) # la pagina parece que funciona por tiempo, asi asegura mas imgs diferentes
    return



if __name__ == "__main__":
   main()
