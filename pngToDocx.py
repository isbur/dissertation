from docx import *

wd = Document()
for i in range(3, 23):
    wd.add_picture("Вопрос "+str(i)+".png")
wd.save('summary.docx')