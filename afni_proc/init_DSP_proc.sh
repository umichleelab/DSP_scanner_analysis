#!/bin/bash

## USAGE: standardproc.sh subject id

subject=$1

PROJ_PATH=/data/home/tarazlee/DSP/$subject/

cd $PROJ_PATH
for scan in training reward
do
echo "starting afni_proc on $scan"

cd $PROJ_PATH$scan
mkdir afni_proc
cd afni_proc
afni_proc.py \
  -bash \
  -blocks align volreg mask blur scale \
  -subj_id $subject \
  -anat_has_skull no \
  -dsets \
  ../func/tprun_01.nii.gz ../func/tprun_02.nii.gz ../func/tprun_03.nii.gz ../func/tprun_04.nii.gz \
  ../func/tprun_05.nii.gz ../func/tprun_06.nii.gz ../func/tprun_07.nii.gz ../func/tprun_08.nii.gz\
  -copy_anat ../../anat/anat.nii.gz \
  -volreg_tlrc_warp \
  -tlrc_anat \
  -tlrc_base /usr/local/afni/MNI152_T1_2009c+tlrc \
  -tlrc_NL_warp \
  -tlrc_NL_awpy_rm no \
  -tlrc_rmode cubic \
  -tlrc_no_ss \
  -blur_size 6.0 \
  -align_opts_aea -ginormous_move -AddEdge -epi_strip 3dAutomask \
  -move_preproc_files \
  -scr_overwrite \
  -mask_apply group \
  -mask_segment_anat yes
  
done
