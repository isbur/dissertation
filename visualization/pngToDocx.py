from docx import *
import os 
import sys


if len(sys.argv)==2:
    Postfix = sys.argv[1]
else:
    print("Wrong number of arguments")
    sys.exit(1)
dirname = os.path.dirname(__file__)


wd = Document()
section = wd.sections[0]
chiselko = shared.Inches(0.5)
section.left_margin, section.right_margin, section.top_margin, section.bottom_margin = chiselko, chiselko, chiselko, chiselko
for i in range(1, 23):
    wd.add_picture( os.path.join(dirname, "Вопрос "+str(i)+Postfix+".png") )

wd.save( os.path.join(dirname, 'summary' + Postfix + '.docx') )