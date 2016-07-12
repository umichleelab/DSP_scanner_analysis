#!/bin/bash

## USAGE: standardproc.sh subject id

subject=$1
TMS_ROI=$2

PROJ_PATH=/data/home/tarazlee/DSP/$subject/reward/
#STANDARDS_PATH=/home/taraz/standards/
cd $PROJ_PATH/afni_proc/
pwd
#source ~/.bashrc_MATT_source # need to source Matt's files for afni_proc
echo "starting afni_proc"
#-blocks align volreg tlrc mask scale blur regress 
afni_proc.py \
  -bash \
  -script AM_reward_proc_"$subject" \
  -out_dir "$subject".AM_reward_results \
  -blocks mask regress  \
  -subj_id $subject \
  -dsets \
    "$subject".results/preproc.data/pb03."$subject".r*.scale+tlrc.HEAD \
  -scr_overwrite \
  -regress_basis_multi dmBLOCK GAM dmBLOCK GAM dmBLOCK GAM dmBLOCK GAM \
  -regress_stim_types AM2 AM2 AM2 AM2 AM2 AM2 AM2 AM2 \
  -regress_compute_tsnr no \
  -regress_est_blur_errts \
  -mask_apply epi \
  -regress_no_fitts \
  -regress_polort 4 \
  -regress_no_iresp \
  -regress_apply_mot_types demean deriv \
  -regress_est_blur_epits \
  -regress_errts_prefix ERRTS.$subject \
  -regress_stim_times \
    "$PROJ_PATH"behavior/"$subject"_correct_A_AM_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_A_AM_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_AM_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_AM_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_AM_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_AM_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_AM_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_AM_reward_onsets.txt \
   -regress_stim_labels \
    A_cor_move \
    A_cor_reward \
    A_incor_move \
    A_incor_reward \
    B_cor_move \
    B_cor_reward \
    B_incor_move \
    B_incor_reward \
  -regress_reml_exec \
  -test_stim_files no \
  -regress_opts_reml -GOFORIT \
  -regress_opts_CS -prefix ClustSimOutput \
  -regress_local_times \
  -regress_opts_3dD \
  -num_glt 4 \
  -GOFORIT 6 \
  -gltsym     "SYM: +.5*A_cor_reward[1] +.5*B_cor_reward[1] -.5*A_incor_reward[1] -.5*A_incor_reward[1]" \
  -glt_label 1 "ampRew_c-i" \
  -gltsym     "SYM: +.5*A_cor_move[1] +.5*B_cor_move[1] -.5*A_incor_move[1] -.5*A_incor_move[1]"\
  -glt_label 2 "ampMove_c-i" \
  -gltsym     "SYM: +.25*A_cor_reward[1] +.25*A_incor_reward[1] +.25*B_cor_reward[1] +.25*B_incor_reward[1]"\
  -glt_label 3 "rewardAMlin" \
  -gltsym     "SYM: +.25*A_cor_move[1] +.25*A_incor_move[1] +.25*B_cor_move[1] +.25*B_incor_move[1]"\
  -glt_label 4 "moveAMlin" 

