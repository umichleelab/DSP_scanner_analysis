#!/bin/bash
# gzip all nifti files in raw_data

for subject in $*
do
cd /data/home/tarazlee/DSP/$subject/training/raw_data/anatomy/t1spgr*
gzip *.nii
tar -zcvf dicom.tar.gz dicom/ --remove-files

for scan in training reward
do
cd /data/home/tarazlee/DSP/$subject/$scan/raw_data/
tar -zcvf raw.tar.gz raw/  --remove-files
tar -zcvf dicom.tar.gz dicom/ --remove-files
for run in 1 2 3 4 5 6 7 8
do
echo "$subject $scan $run"
cd /data/home/tarazlee/DSP/$subject/$scan/raw_data/func/dsp/run_0$run/
gzip *.nii
cd /data/home/tarazlee/DSP/$subject/$scan/raw_data/func/resting/run_01/
gzip *.nii
cd /data/home/tarazlee/DSP/$subject/$scan/raw_data/


echo "complete"

done
done
done

