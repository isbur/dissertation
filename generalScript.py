from subprocess import call
# https://ru.wikipedia.org/wiki/%D0%9D%D0%B0%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5_%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D1%8B
#call(["python", "./main_generator/main_generator.py", "721", "1", "0", "0", "U"]) 
#call(["python", "./visualization/visualize.py", "U"])
#call(["python", "./visualization/pngToDocx.py", "U"])

#call(["python", "./main_generator/main_generator.py", "494", "0", "1", "0", "A"])
#call(["python", "./visualization/visualize.py", "A"])
#call(["python", "./visualization/pngToDocx.py", "A"])

call(["python", "./main_generator/main_generator.py", "313", "0", "0", "1", "K"])
call(["python", "./visualization/visualize.py", "K"])
call(["python", "./visualization/pngToDocx.py", "K"])