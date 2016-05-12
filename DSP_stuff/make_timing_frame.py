import numpy as np
import sys
import os
import pandas as pd

ITER = raw_input("Please enter iteration number:")
STIM_PREFIX = 'stim_results_1.2TR_30/stimes.'+ ITER + '_'

BETAS = ['A5', 'A10', 'A30', 'B5', 'B10', 'B30', 'A5move', 'A10move', 
		 'A30move', 'B5move', 'B10move', 'B30move']
		 
NUM_RUNS = 8
	
All_txt_frame = pd.DataFrame()

for b,beta in enumerate(BETAS):
	
	fname = STIM_PREFIX + str(b+1).zfill(2) + '_' + beta+ '.1D' # zfill pads zeros on int <10
	temp_frame = pd.read_table(fname, delim_whitespace=True, header = None) # get stim times for beta
	betaname = [beta]*len(temp_frame)
	temp_frame['beta']=betaname
	All_txt_frame = pd.concat((All_txt_frame, temp_frame)) # make big data frame for all betas
	
All_txt_frame['run']=All_txt_frame.index # make run column
All_txt_frame.reset_index(level=0,inplace=True) # reset index
All_lag_frame = pd.DataFrame()

for rnum in range(NUM_RUNS):
	print 'starting run' + str(rnum)
	seq = []
	reward = []
	init_delay = []
	move_delay = []
	run_frame = All_txt_frame[All_txt_frame.run==rnum]
	run_frame.drop(['index','run'],axis = 1,inplace=True)
	stacked = pd.melt(run_frame, id_vars = ['beta'], value_vars = range(5))
	stacked.sort(['value'],inplace=True)
	stacked['lags']=stacked.value-stacked.shift().value
	stacked.reset_index(inplace=True)
	stacked.lags[0]=stacked.value[0]
	stacked.drop(['index','variable'], axis = 1, inplace=True)
	stacked.rename(columns={'value':'time'}, inplace=True)
	All_lag_frame = pd.concat((All_lag_frame,stacked))
	

All_lag_frame['sequences'] = All_lag_frame['beta'].str[0]
rew_vals = All_lag_frame['beta'].str[1:]
rew_vals = rew_vals.str.rstrip('move')
All_lag_frame['reward']=rew_vals
rew_frame = All_lag_frame.iloc[::2,:]
move_frame = All_lag_frame.iloc[1::2,:]
rew_frame['move_iti']= move_frame['lags'].values
rew_frame.reset_index(inplace=True)
rew_frame.drop('index',axis=1,inplace=True)
rew_frame.to_csv('DSP_Timings_%s.csv' % ITER, sep = '\t')

"""
A5_file = STIM_PREFIX
A10_file = 
A20_file =
B5_file =
B10_file = 
B20_file = 
A5move_file =
A10move_file = 
A20move_file =
B5move_file =
B10move_file = 
B20move_file = 
"""
