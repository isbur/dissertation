from docx import *
from glob import glob
from natsort import natsorted
import os 
from os.path import join
import sys


if len(sys.argv)==2:
    Postfix = sys.argv[1]
else:
    print("Wrong number of arguments")
    sys.exit(1)
#Postfix = "U"
dirname = os.path.dirname(__file__)


wd = Document()
section = wd.sections[0]
chiselko = shared.Inches(0.5)
section.left_margin, section.right_margin, section.top_margin, section.bottom_margin = chiselko, chiselko, chiselko, chiselko

fileList = glob(join(dirname, "./*" + Postfix + ".png"))
fileList = natsorted(fileList)
for filename in fileList:
    wd.add_picture( filename )

wd.save( os.path.join(dirname, 'summary' + Postfix + '.docx') )