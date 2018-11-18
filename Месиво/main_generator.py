from setRespondentType import RespondentType
import weightedChoice as wc

from numpy import *
from openpyxl import Workbook
from operator import add
from os import listdir
from os.path import isfile, join


N = 1534

#RespondentTypesWeights = {
    #"Узбеки без семьи": 700, # https://ru.wikipedia.org/wiki/%D0%9D%D0%B0%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5_%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D1%8B
    #"Армяне Типичные Трудовые": 500,
    #"Казахи-студенты": 300
#}
RespondentTypesWeights = {
    "Узбеки без семьи": 0,
    "Армяне Типичные Трудовые": 1,
    "Казахи-студенты": 0
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
wb.save('responses.xlsx')

    