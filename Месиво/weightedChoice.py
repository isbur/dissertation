import math
import random

def weightedChoice(weights, qnumber=0):
    totals = []
    running_total = 0
    #if qnumber == 34:
        #print(weights)
    for w in weights:
        #if qnumber == 34:
            #print(w, type(w))
        if ( type(w)==type(1.0) ) or ( type(w)==type(1) ):
            #if qnumber == 34:
                #print("Hello")
            running_total += w
            totals.append(running_total)
    
    rnd = random.random() * running_total
    #if qnumber == 34:
        #print(rnd, totals)
    for i, total in enumerate(totals):
        #if qnumber == 34:
            #print(rnd, total, i) 
        if rnd < total:
            if qnumber == 34:
                return i + 20
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
    for i, Distribution in enumerate(myRespondentTypeObject.Distributions):
        #print(i)
        #if i ==34:
            #print(i, ": ", Distribution)
        Answer.append(weightedChoice(Distribution, i))
    #print(Answer)
    
    return Answer
    
    