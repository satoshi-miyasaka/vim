#!/bin/python3
import os
import math

dict_file_name = '/home/miyachy/vim/dict/python3'

file = open(dict_file_name + '_os.dict', 'w')
for func in dir(os):
	file.write(func + "\n")
file.close()

file = open(dict_file_name + '_math.dict', 'w')
for func in dir(math):
	file.write(func + "\n")
file.close()


