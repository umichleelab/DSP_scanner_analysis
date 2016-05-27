import random, sys
import pandas as pd
import numpy as np
from pandas import Series, DataFrame
from time import sleep
from makeFileModule import *

# suffixes for files to be written
rewFileStem = "_AM_reward_onsets"
moveOnsetFileStem = "_AM_move_onsets"
moveOffsetFileStem = "_AM_move_offsets"

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
runstarts = []
blockOffsets = []
allRunTimes = []

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
        
        # Initialize onsets to be of length NUMRUNS
        A_rew_onsets = [[]for i in range(NUMRUNS)]
        B_rew_onsets = [[]for i in range(NUMRUNS)]
        A_move_onsets = [[]for i in range(NUMRUNS)]
        A_move_offsets = [[]for i in range(NUMRUNS)]
        B_move_onsets = [[]for i in range(NUMRUNS)]
        B_move_offsets = [[]for i in range(NUMRUNS)]

        for runNum in range(0,NUMRUNS):
            for tind, trial in frame.iterrows():
                trialRunNum = trial['block']-1
                trialval = trial['reward']
                ampval = amp_vals[reward_vals.index(trialval)]
                if runNum == trialRunNum:
                    if trial['sequence']=='A':
                        A_rew_onsets[runNum].append("%.2f*%i" % (trial['rew_onset']/1000., ampval))
                        A_onset = trial['move_onset']/1000.
                        A_offset = trial['move_offset']/1000.
                        A_move_onsets[runNum].append("%.2f*%i:%f" % (A_onset, ampval, A_offset-A_onset))
                        
                    elif trial['sequence']=='B':
                        B_rew_onsets[runNum].append("%.2f*%i" % (trial['rew_onset']/1000., ampval))
                        B_onset = trial['move_onset']/1000.
                        B_offset = trial['move_offset']/1000.
                        B_move_onsets[runNum].append("%.2f*%i:%f" % (B_onset, ampval, B_offset-B_onset))
                    
        makeStimFiles(beh_path,SUB, stem+'_A'+rewFileStem, A_rew_onsets)
        makeStimFiles(beh_path,SUB, stem+'_B'+rewFileStem, B_rew_onsets)
        makeStimFiles(beh_path,SUB, stem+'_A'+moveOnsetFileStem, A_move_onsets)
        makeStimFiles(beh_path,SUB, stem+'_B'+moveOnsetFileStem, B_move_onsets)

            
                   
if __name__ == '__main__':
    main()
