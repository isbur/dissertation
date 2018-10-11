import math
import random

def weightedChoice(weights):
    totals = []
    running_total = 0

    for w in weights:
        running_total += w
        totals.append(running_total)

    rnd = random.random() * running_total
    for i, total in enumerate(totals):
        if rnd < total:
            return i

#Distributions = [
    ##1
    ## https://ru.wikipedia.org/wiki/%D0%9D%D0%B0%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5_%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D1%8B
    #{'0':[35595, 106466, 9393]},
    ##2
    #{'0':[1,0,0],
     #'1':[0,1,0], 
     #'2':[0,0,1]
     #},
    ##3
    #{
        #'0':[80,16]+([4-x for x in range(0,4)]), 
        #'1':[50 - x for x in range(0, 50)],
        #'2':[math.exp(-x**2) for x in range(0,5)]
             #}
#]

def generateAnswer(myRespondentTypeObject):
    Answer = []
    for Distribution in myRespondentTypeObject.Distributions:
        Answer.append(weightedChoice(Distribution))
    
    return Answer
    
    