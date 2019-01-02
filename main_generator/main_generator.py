from setRespondentType import RespondentType
import weightedChoice as wc

from numpy import *
from openpyxl import Workbook
from operator import add
from os import listdir
from os.path import isfile, join, dirname
import sys


# Сделать так, чтобы всё это передавалось как параметры вызова, да ещё и с помощью файлов

if len(sys.argv)==6:
    N = int(sys.argv[1])
    UWeight, AWeight, KWeight =  sys.argv[2],  sys.argv[3],  sys.argv[4]
    Postfix = sys.argv[5]
else:
    print("Wrong number of arguments")
    sys.exit(1)
    

RespondentTypesWeights = {
    "Узбеки без семьи": UWeight, 
    "Армяне Типичные Трудовые": AWeight,
    "Казахи-студенты": KWeight
}


RespondentTypes = {}
for stem in list(RespondentTypesWeights.keys()):
    RespondentTypes[stem] = RespondentType.setViaFile(stem + ".xlsm")


ResponsesTable = []
for i in range(N):
    A = array(list(RespondentTypesWeights.items()))
    weights = list(map(float, A[0:len(A),1:]))
    respondentTypeName = A[wc.weightedChoice(weights), 0]
    ResponsesTable.append( wc.generateAnswer(RespondentTypes[respondentTypeName]) )

wb = Workbook()
ws = wb.active
ws.append([
    "1. Страна",
    "2. Национальность",
    "3. Как долго живёте",
    "4. Где",
    "5. Планы",
    "6. Русский",
    "7. Общение на работе",
    "8. Общение вне работы",
    "9. Дети должны",
    "10. Медиа на:",
    "11.1 Взятки на границе",
    "11.2 Взятки в полиции",
    "11.3 Расовая дискриминация",
    "11.4 Религия",
    "11.5 Преступления",
    "11.6 Работа",
    "11.7 Низкая зп",
    "11.8 Работодатель мудак",
    "11.9 Тяжёлый труд",
    "11.10 Жильё",
    "11.11 Медицина",
    "11.12 Юри",
    "11.13 Русский",
    "11.14 Куда с проблемами",
    "11.15 Где работать, жить",
    "12. Есть диаспора?",
    "13. А вы в ней?",
    "14. Первый помощник",
    "15. Гугл работы",
    "16. Гугл жилья",
    "17. НКО",
    "18. Брак с местной",
    "19. РФянин",
    "20. Антимуслим",
    "21. Возраст",
    "22. Образование"
    ])
for Response in ResponsesTable:
    ws.append(Response)
    
wb.save( join(dirname(__file__), '../common/' + 'responses' + Postfix + '.xlsx') )

    