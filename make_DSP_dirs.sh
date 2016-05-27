for subject in $*
do

echo "making $subject directory"
mkdir /data/home/tarazlee/DSP/$subject

echo "making $subject anatomical, training, and reward dirs"
mkdir /data/home/tarazlee/DSP/$subject/anat
mkdir /data/home/tarazlee/DSP/$subject/training
mkdir /data/home/tarazlee/DSP/$subject/reward
mkdir /data/home/tarazlee/DSP/$subject/dti


echo "making $subject data dirs"
for directory in training reward
do

#mkdir /data/home/tarazlee/DSP/$subject/$directory/GLM
#mkdir /data/home/tarazlee/DSP/$subject/$directory/GLM_AM
#mkdir /data/home/tarazlee/DSP/$subject/$directory/epi
mkdir /data/home/tarazlee/DSP/$subject/$directory/behavior
mkdir /data/home/tarazlee/DSP/$subject/$directory/raw_data
mkdir /data/home/tarazlee/DSP/$subject/$directory/func
done
done
