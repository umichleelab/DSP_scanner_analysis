#!/bin/bash
# gzip all nifti files in raw_data

for subject in $*
do
for scan in training reward
do
for run in 1 2 3 4 5 6 7 8
do
echo "$subject $scan $run"
cd /data/home/tarazlee/DSP/$subject/$scan/raw_data/func/dsp/run_0$run/
gzip *.nii
echo "complete"

done
done
done

