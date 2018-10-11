from setRespondentType import RespondentType
import weightedChoice as wc

from numpy import *
from openpyxl import Workbook
from operator import add
from os import listdir
from os.path import isfile, join


N = 10

RespondentTypes = {}
onlyfiles = [f for f in listdir("./") if isfile(join("./", f))]
for file in onlyfiles:
    if file.find(".xlsx") != -1:
        RespondentTypes[file[0:len(file)-5]] = RespondentType.setViaFile(file)
        
RespondentTypesWeights = {
    "Казахи-студенты": 0.5,
    "Армяне": 0.5,
    "Орки": 0
}

ResponsesTable = []
for i in range(N):
    A = array(list(RespondentTypesWeights.items()))
    weights = list(map(float, A[0:len(A),1:]))
    respondentTypeName = A[wc.weightedChoice(weights), 0]
    ResponsesTable.append( wc.generateAnswer(RespondentTypes[respondentTypeName]) )

wb = Workbook()
ws = wb.active
for Response in ResponsesTable:
    ws.append(Response)
wb.save('responses.xlsx')

    