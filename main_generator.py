from setRespondentType import RespondentType
import weightedChoice 

from operator import add
from os import listdir
from os.path import isfile, join


N = 1

RespondentTypes = {}
onlyfiles = [f for f in listdir("./") if isfile(join("./", f))]
for file in onlyfiles:
    if file.find(".xlsx") != -1:
        RespondentTypes[file[0:len(file)-5]] = RespondentType.setViaFile(file)


#for i in range(N):
    