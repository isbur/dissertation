from pathlib import Path
from subprocess import call
import tkinter as tk
from tkinter import scrolledtext
import math


class Application(tk.Frame):
    
    
    def __init__(self, master=None):
        self.counter = 0
        
        print(self.counter)
        super().__init__(master)
        self.master = master
        self.pack()
        root.protocol("WM_DELETE_WINDOW", self.prepare)
        self.create_widgets()
        
        
    def create_widgets(self):
        self.hi_there = tk.Button(self)
        self.hi_there["text"] = "Я молодец!"
        self.hi_there["command"] = self.count
        self.hi_there.pack(side="top")
        self.T = tk.Label(self)
        self.T.pack()

    def count(self):
        
        self.counter = self.counter + 1
        
        self.T.destroy()
        self.T = tk.Label(self, text = 'Начислено ' + str(int(math.log2(self.counter))*10) + ' булькитов')
        self.T.pack()
        print("hi there, everyone!", self.counter)
    
    
    def prepare(self):
        file = open("Диссертация.txt", "r")
        temp = file.read()
        file.close()
        if temp:
            temp = int(temp)
        else:
            temp = 0        
        file = open("Диссертация.txt", "w")
        
        if(self.counter):
            log2counter = int(math.log2(self.counter))*10
        else:
            log2counter = 0
        file.write(str(log2counter+temp))
        
        file.close()
        
        print(log2counter)
        print((log2counter + temp))
        
        root.destroy()
        

call(["explorer", str(Path.home() / 'Documents' / 'GitHub' / 'dissertation')])

root = tk.Tk()
app = Application(master=root)
app.mainloop()


