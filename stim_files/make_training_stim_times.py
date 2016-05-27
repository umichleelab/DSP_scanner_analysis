import random, sys
import pandas as pd
import numpy as np
from pandas import Series, DataFrame
from time import sleep
from makeFileModule import *

# suffixes for files to be written
cueFileStem = "_cue_onsets"
moveOnsetFileStem = "_move_onsets"
moveOffsetFileStem = "_move_offsets"

# define values
reward_vals = [5, 10, 20]
amp_vals = [1,2,3] # amplitude modulations
CORRECT = 1
INCORRECT = 0

# define experiment parameters
RUNLENGTH = 30
SUB = raw_input("Please enter subject number:")
NUMRUNS = 8 
TOTALTRIALS = NUMRUNS * RUNLENGTH

# path to behavioral data
beh_path = "/data/home/tarazlee/DSP/" + SUB + "/training/behavior/"
filename = SUB + "_training_output.csv"
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
        A_cue_onsets = [[]for i in range(NUMRUNS)]
        B_cue_onsets = [[]for i in range(NUMRUNS)]
        A_move_onsets = [[]for i in range(NUMRUNS)]
        A_move_offsets = [[]for i in range(NUMRUNS)]
        B_move_onsets = [[]for i in range(NUMRUNS)]
        B_move_offsets = [[]for i in range(NUMRUNS)]
        rand_cue_onsets = [[]for i in range(NUMRUNS)]
        rand_move_onsets = [[]for i in range(NUMRUNS)]
        rand_move_offsets = [[]for i in range(NUMRUNS)]

        for runNum in range(0,NUMRUNS):
            for tind, trial in frame.iterrows():
                trialRunNum = trial['block']-1
                
                if runNum == trialRunNum:
                    if trial['sequence']=='A':
                        A_cue_onsets[runNum].append("%.2f" % (trial['cue_onset']/1000.))
                        A_onset = trial['move_onset']/1000.
                        A_offset = trial['move_offset']/1000.
                        A_move_onsets[runNum].append("%.2f:%f" % (A_onset, A_offset-A_onset))
                        
                    elif trial['sequence']=='B':
                        B_cue_onsets[runNum].append("%.2f" % (trial['cue_onset']/1000.))
                        B_onset = trial['move_onset']/1000.
                        B_offset = trial['move_offset']/1000.
                        B_move_onsets[runNum].append("%.2f:%f" % (B_onset, B_offset-B_onset))
                    elif trial['sequence']=='random':
                        rand_cue_onsets[runNum].append("%.2f" % (trial['cue_onset']/1000.))
                        rand_onset = trial['move_onset']/1000.
                        rand_offset = trial['move_offset']/1000.
                        rand_move_onsets[runNum].append("%.2f:%f" % (A_onset, A_offset-A_onset))
                    
        makeStimFiles(beh_path,SUB, stem+'_A_'+cueFileStem, A_cue_onsets)
        makeStimFiles(beh_path,SUB, stem+'_B_'+cueFileStem, B_cue_onsets)
        makeStimFiles(beh_path,SUB, stem+'_A_'+moveOnsetFileStem, A_move_onsets)
        makeStimFiles(beh_path,SUB, stem+'_B_'+moveOnsetFileStem, B_move_onsets)
        makeStimFiles(beh_path,SUB, stem+'_rand_'+cueFileStem, rand_cue_onsets)
        makeStimFiles(beh_path,SUB, stem+'_rand_'+moveOnsetFileStem, rand_cue_onsets)
                   
if __name__ == '__main__':
    main()
