#!/bin/bash
# Make symlinks to anatomical scan and preprocessed functional scans in the relevant 
# subfolders of DSP subjects.  Assumes 8 runs per person.

for subject in $*
do
echo "Linking anatomical"
cd /data/home/tarazlee/DSP/$subject/anat/
ln -s /data/home/tarazlee/DSP/$subject/training/raw_data/anatomy/t1spgr*/eht* .
for scan in training reward
do
echo "Linking functionals -- $scan"
cd /data/home/tarazlee/DSP/$subject/$scan/func/
for run in 1 2 3 4 5 6 7 8
do
ln -s /data/home/tarazlee/DSP/$subject/$scan/raw_data/func/dsp/run_0$run/rtprun_0$run.nii.gz .
ln -s /data/home/tarazlee/DSP/$subject/$scan/raw_data/func/dsp/run_0$run/run_0$run.nii.gz .
ln -s /data/home/tarazlee/DSP/$subject/$scan/raw_data/func/dsp/run_0$run/realign.dat .

done
done
done

