import random, sys
import pandas as pd
import numpy as np
from pandas import Series, DataFrame
from time import sleep

def makeStimFiles(path, subjectNum, fileStem, times):
    f = open(path+str(subjectNum) + '_' +fileStem + '.txt', 'w')
    for j in range(0,len(times)):
        if times[j]==[]: 
            f.write('*\n')
        else:
            for time in times[j]:
                #print time
                f.write(time+' ')
            f.write('\n')
    f.close()

        
def makeSplitStimFiles(path, subjectNum, fileStem, times):
    first = times[:len(times)/2]
    second = times[len(times)/2:]
    numFirstHalf = len(times)/2
    numSecHalf = len(times)-numFirstHalf

    # For first half
    f = open(path+str(subjectNum) + '_' +fileStem + '_first_half'+'.txt', 'w')
    for j in range(0,len(first)):
        if first[j]==[]: 
            f.write('*\n')
        else:
            for time in first[j]:
                #print time
                f.write(time+' ')
            f.write('\n')
    for r in range(0,numSecHalf):
        f.write('*\n') # empty second half
    f.close()
    # For second half
    g = open(path+str(subjectNum) + '_' +fileStem + '_second_half'+'.txt', 'w')
    for rI in range(0,numFirstHalf):
        g.write('*\n') # empty first half
    for j in range(0,len(second)):
        if second[j]==[]: 
            g.write('*\n')
        else:
            for time in second[j]:
                #print time
                g.write(time+' ')
            g.write('\n')
    g.close()
