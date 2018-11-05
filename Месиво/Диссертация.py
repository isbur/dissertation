import math
from pathlib import Path
import random
from subprocess import call
import tkinter as tk
from tkinter import scrolledtext
from tkinter import messagebox



class Application(tk.Frame):
    
    
    def __init__(self, master=None):
        self.counter = 0
        self.sum = 0
        
        print(self.counter)
        super().__init__(master)
        self.master = master
        self.pack()
        root.protocol("WM_DELETE_WINDOW", self.prepareToDie)
        self.create_widgets()
        
        
    def create_widgets(self):
        self.hi_there = tk.Button(self)
        self.hi_there["text"] = "Я молодец!"
        self.hi_there["command"] = self.count
        self.hi_there.pack(side="top")
        self.T = tk.Label(self)
        self.S = tk.Label(self)

    def count(self):
        
        self.counter = self.counter + 1
        d = 2
        base = 10 + self.counter*d
        bottom = -5
        top = 5
        delta = base + random.randint(bottom, top)
        self.sum = self.sum + delta
        
        self.T.destroy()
        self.T = tk.Label(self, text = 'Начислено ' + str(delta) + ' булькитов')
        self.T.pack()
        
        self.S.destroy()
        self.S = tk.Label(self, text = str(self.counter) + ' items in row')
        self.S.pack()
        print("hi there, everyone!", self.counter)
    
    
    def prepareToDie(self):
        file = open("Диссертация.txt", "r")
        temp = file.read()
        print(temp)
        file.close()
        if temp:
            temp = int(temp)
        else:
            temp = 0        
        file = open("Диссертация.txt", "w")
        
        file.write(str(temp + self.sum))
        
        file.close()
        
        self.FinalWord = messagebox.showinfo("Сегодня ты молодец!", "Набрано " + str(self.sum) + " булькитов.\nВсего булькитов " + str(temp + self.sum) + ".")
        
        root.destroy()
        

call(["explorer", str(Path.home() / 'Documents' / 'GitHub' / 'dissertation')])

root = tk.Tk()
app = Application(master=root)
app.mainloop()


