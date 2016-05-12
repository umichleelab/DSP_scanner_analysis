import random, sys
import pandas as pd
import numpy as np
from pandas import Series, DataFrame

# file to parse

stimFileStem = "training_stimTimes_run_"
training = True 
BLOCKLENGTH = 5
RUNLENGTH = 35
SUB = raw_input("Please enter subject number:")
NUMRUNS = int(raw_input("Please enter number of runs:"))
filename = SUB +"_training_output.csv"
TOTALTRIALS = NUMRUNS * RUNLENGTH
BLOCKS_PER_RUN = RUNLENGTH/BLOCKLENGTH
blockstarts = []
blockOffsets = []
allRunTimes = []

beh_path = "/home/tarazlee/DSP_scanner/" + SUB + "/training/behavior/"
data = pd.read_csv(beh_path+filename, sep = "\t")

def main():
    if training:
        for trial in range(0,TOTALTRIALS):
            if trial % 5 == 0:
                blockstarts.append(data.readyOnsets[trial])
            if trial % 5 == 4:
                blockOffsets.append(data.moveOffsets[trial]) # check to see if it's moveOffsets or moveOff"E"ts 
                #print trial, blockstarts[(trial)/5], blockOffsets[(trial)/5]
        for runNum in range(0, NUMRUNS):
            print runNum
            runTimes = []
            for block in range(BLOCKS_PER_RUN):
                start = blockstarts[block+(runNum*BLOCKS_PER_RUN)]
                end = blockOffsets[block+(runNum*BLOCKS_PER_RUN)]
                duration = (end - start)/1000.
                runTimes.append(str(start/1000.)+':'+str(duration))
                #print block+runNum, start, end, duration
            allRunTimes.append(runTimes)

    makeStimFiles(beh_path + SUB, allRunTimes)
    
    
    
    
def makeStimFiles(subjectNum, times):
    for i in range(0,len(times)):
        f = open(str(subjectNum) + '_' +stimFileStem + str(i+1) + '.txt', 'w')
        for j in range(0,len(times)):
            if i != j: 
                f.write('*\n')
            else:
                for time in times[j]:
                    print time
                    f.write(time+' ')
                f.write('\n')
        f.close()
        
    #1/0
        
if __name__ == '__main__':
    main()
