#!/bin/bash

## USAGE: standardproc.sh subject id

subject=$1

PROJ_PATH=/data/home/taraz/DSP/$subject/

cd $PROJ_PATH
for scan in training reward
echo "starting afni_proc"

cd $PROJ_PATH$scan
mkdir afni_proc
cd afni_proc
afni_proc.py \
  -bash \
  -blocks align mask blur scale \
  -subj_id $subject \
  -anat_has_skull no \
  -dsets \
  ../func/epi_run1.nii.gz ../func/epi_run2.nii.gz ../func/epi_run3.nii.gz ../func/epi_run4.nii.gz \
  ../func/epi_run5.nii.gz ../func/epi_run6.nii.gz \
  -copy_anat ../../anat/anat.nii.gz \
  -volreg_tlrc_warp \
  -tlrc_anat \
  -tlrc_base MNI152_T1_2009c+tlrc \
  -tlrc_NL_warp \
  -tlrc_NL_awpy_rm no \
  -tlrc_rmode cubic \
  -tlrc_no_ss
  -blur_size 6.0 \
  -align_opts_aea -AddEdge -epi_strip 3dAutomask \
  -move_preproc_files \
  -scr_overwrite \
  -mask_apply group \
  -mask_segment_anat yes
  
