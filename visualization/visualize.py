from docx import *
import matplotlib.pyplot as plt
import numpy as np
from openpyxl import load_workbook
import os
import sys
from textwrap import fill


if len(sys.argv)==2:
    Postfix = sys.argv[1]
else:
    print("Wrong number of arguments")
    sys.exit(1)
dirname = os.path.dirname(__file__)
wb = load_workbook( os.path.join(dirname, "../common/responses" + Postfix + ".xlsx") )
ws = wb.active


# Parse labels
wd = Document( os.path.join(dirname, "../common/Anketa.docx") )
questionNumber = 0
Labels = []
for paragraph in wd.paragraphs:
    if paragraph.text.find("Другое") != -1:
        continue
    
    if paragraph.text.find("Вопрос") != -1:
        Labels.append([paragraph.text])
        questionNumber += 1
        continue
    
    if paragraph.text.find("Сколько") != -1:
        column = [cell.value for cell in [column for column in ws.iter_cols(min_col=questionNumber, max_col=questionNumber)][0]][1:]
        Labels[len(Labels) - 1] = Labels[len(Labels) - 1] + list(np.unique(column))[2:]
        continue
    
    if paragraph.style.name == 'List Paragraph':
        Labels[len(Labels) - 1].append(paragraph.text)
        continue
    

# Make plots
#def buildMyLovelyPie(ws):
#    # Preparation
#    fig, ax = plt.subplots(figsize=(6, 8), subplot_kw=dict(aspect="equal", anchor = "N"))

questionNumber = 0
for Label in Labels:
    
    
    questionNumber += 1
    
    
    # Make a choice!
    if questionNumber == 11:
        decision = '911'
    elif questionNumber == 21:
        decision = 'Make a roll!'
    else:
        decision = 'U no da wae'
    
    
    if decision == 'U no da wae':
        if questionNumber < 11:
            colIndex = questionNumber
        else:
            colIndex = questionNumber + 14
        # Preparation
        #fig, ax = plt.subplots(ncols = 2, figsize=(6, 3), subplot_kw=dict(aspect="equal"))
        fig, ax = plt.subplots(figsize=(6, 8), subplot_kw=dict(aspect="equal", anchor = "N"))
        # Extract data
        column = [cell.value for cell in [column for column in ws.iter_cols(min_col=colIndex, max_col=colIndex)][0]][1:]
        curChartLabels = [fill(x, 60) for x in Labels[questionNumber-1][1:]]
        # Count values
        hist = np.histogram(column, bins = range(0, len(curChartLabels)+1 ) )
        # Extract data and omit zeros
        hist_data = [x for x in hist[0] if x != 0]
        hist_labels = [curChartLabels[i] for i, x in enumerate(hist[0]) if x != 0]
        # Plot 'em all!
        wedges, texts, autotexts = ax.pie( hist_data, autopct = lambda pct: "{:.1f}%".format(pct), pctdistance = 1.3)
        ax.legend(wedges, hist_labels,
                  loc="center",
                  bbox_to_anchor=(0.5, -0.2))        
    
    elif decision == '911':
        heights = []
        for i in range(15):
            column = [cell.value for cell in [column for column in ws.iter_cols(min_col=questionNumber+i, max_col=questionNumber+i)][0]][1:]
            hist = np.histogram(column, bins = range(0, 3) ) 
            heights.append(hist[0][0])
        fig, ax = plt.subplots()
        barplot = plt.bar(x = [x for x in range(1, 16)], height=heights)
        
    elif decision == 'Make a roll!':
        column = [cell.value for cell in [column for column in ws.iter_cols(min_col=questionNumber+14, max_col=questionNumber+14)][0]][1:]
        uniqueItemsList = list(map(float, np.unique(column)))
        plt.hist( column, bins = uniqueItemsList + [uniqueItemsList[-1]], rwidth = 0.5, align = "left" )
        plt.xticks(uniqueItemsList)
            
    else:
        print('No (?) decision was made')
        sys.exit()

    # Universal ending
    
    #### Better be used while creating summary.docx
    #curChartTitle = Labels[questionNumber-1][0]
    #ax.set_title(curChartTitle)
    
    plt.savefig( os.path.join(dirname, "Вопрос "+str(questionNumber)+Postfix+".png") )
    plt.close()
       
