import random, sys
import pandas as pd
import numpy as np
from pandas import Series, DataFrame
from time import sleep
from makeFileModule import *

# # suffixes for files to be written
rewFileStem = "_reward_onsets"
moveOnsetFileStem = "_move_onsets"
moveOffsetFileStem = "_move_offsets"

# define values
reward_vals = [5, 10, 30]
amp_vals = [1,2,3] # amplitude modulations
CORRECT = 1
INCORRECT = 0

# define experiment parameters
RUNLENGTH = 30
SUB = raw_input("Please enter subject number:")

if SUB == '101': # 1st subject had 20 as highest reward val
    reward_vals = [5,10,20]
NUMRUNS = 8 #int(raw_input("Please enter number of runs (6 is standard):"))
TOTALTRIALS = NUMRUNS * RUNLENGTH

# path to behavioral data
beh_path = "/data/home/tarazlee/DSP/" + SUB + "/reward/behavior/"

filename = SUB + "_reward_output.csv"
data = pd.read_csv(beh_path+filename, sep = "\t")

def main():

    for acc in [CORRECT, INCORRECT]:
        correctFrame = data[data.accuracy==CORRECT]
        incorrectFrame = data[data.accuracy==INCORRECT]
        if acc == CORRECT:
            frame = correctFrame
            stem = "correct"
        else:
            frame = incorrectFrame
            stem = "incorrect"
        for val in reward_vals:
            newFrame = frame[frame.reward==val]
            
            # Initialize onsets to be of length NUMRUNS
            A_rew_onsets = [[]for i in range(NUMRUNS)]
            B_rew_onsets = [[]for i in range(NUMRUNS)]
            A_move_onsets = [[]for i in range(NUMRUNS)]
            A_move_offsets = [[]for i in range(NUMRUNS)]
            B_move_onsets = [[]for i in range(NUMRUNS)]
            B_move_offsets = [[]for i in range(NUMRUNS)]

            for runNum in range(0,NUMRUNS):
                for tind, trial in newFrame.iterrows():
                    trialRunNum = trial['block']-1
                    
                    if runNum == trialRunNum:
                        if trial['sequence']=='A':
                            A_rew_onsets[runNum].append("%.2f" % (trial['rew_onset']/1000.))
                            A_onset = trial['move_onset']/1000.
                            A_offset = trial['move_offset']/1000.
                            A_move_onsets[runNum].append("%.2f:%f" % (A_onset, A_offset-A_onset))
                            
                        elif trial['sequence']=='B':
                            B_rew_onsets[runNum].append("%.2f" % (trial['rew_onset']/1000.))
                            B_onset = trial['move_onset']/1000.
                            B_offset = trial['move_offset']/1000.
                            B_move_onsets[runNum].append("%.2f:%f" % (B_onset, B_offset-B_onset))
                        
            makeStimFiles(beh_path,SUB, stem+'_A_'+str(val).zfill(2)+rewFileStem, A_rew_onsets)
            makeStimFiles(beh_path,SUB, stem+'_B_'+str(val).zfill(2)+rewFileStem, B_rew_onsets)
            makeStimFiles(beh_path,SUB, stem+'_A_'+str(val).zfill(2)+moveOnsetFileStem, A_move_onsets)
            makeStimFiles(beh_path,SUB, stem+'_B_'+str(val).zfill(2)+moveOnsetFileStem, B_move_onsets)

            
                   
if __name__ == '__main__':
    main()
