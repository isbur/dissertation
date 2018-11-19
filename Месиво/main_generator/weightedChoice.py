import math
import random

# Maybe I should merge two loops into one
def weightedChoice(weights, qnumber=0):
    totals = []
    running_total = 0
    for w in weights:
        if ( type(w)==type(1.0) ) or ( type(w)==type(1) ):
            running_total += w
            totals.append(running_total)
    
    rnd = random.random() * running_total
    for i, total in enumerate(totals):
        if rnd < total:
            return i
        

def generateAnswer(myRespondentTypeObject):
    Answer = []
    for i, Distribution in enumerate(myRespondentTypeObject.Distributions):
        Answer.append(weightedChoice(Distribution, i))
        if i == 34:
            Answer[len(Answer)-1] += 20
    print(Answer)
    return Answer
    
    