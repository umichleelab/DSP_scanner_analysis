#!/bin/bash

## USAGE: standardproc.sh subject id

subject=$1
TMS_ROI=$2

PROJ_PATH=/home/taraz/TMS_wormy/$subject/$TMS_ROI/
STANDARDS_PATH=/home/taraz/standards/
cd $PROJ_PATH/afni_proc/
pwd
#source ~/.bashrc_MATT_source # need to source Matt's files for afni_proc
echo "starting afni_proc"
#-blocks align volreg tlrc mask scale blur regress 
afni_proc.py \
  -bash \
  -script 3_level_reward_proc_"$subject" \
  -out_dir "$subject".3_level_reward_results \
  -blocks mask regress  \
  -subj_id $subject \
  -dsets \
    "$subject".results/preproc.data/pb03."$subject".r*.scale+tlrc.HEAD \
  -scr_overwrite \
  -regress_basis GAM \
  -regress_stim_types AM2 AM2 times times times times times times \
  -regress_compute_tsnr no \
  -regress_est_blur_errts \
  -mask_apply epi \
  -regress_no_fitts \
  -regress_polort 4 \
  -regress_no_iresp \
  -regress_no_motion \
  -regress_no_motion_demean \
  -regress_3dD_stop \
  -regress_est_blur_epits \
  -regress_errts_prefix ERRTS.$subject \
  -regress_stim_times \
    "$PROJ_PATH"behavior/"$subject"_correct_AM2_move_blocked_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_AM2_move_blocked_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_5_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_10_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_40_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_5_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_10_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_40_reward_onsets.txt \
   -regress_stim_labels \
    cor_move \
    incor_move \
    c_5_reward \
    c_10_reward \
    c_40_reward \
    i_5_reward \
    i_10_reward \
    i_40_reward \
  -regress_reml_exec \
  -test_stim_files no \
  -regress_opts_reml -GOFORIT \
  -regress_opts_CS -prefix ClustSimOutput \
  -regress_local_times \
  -regress_make_cbucket yes \
  -regress_opts_3dD \
  -GOFORIT 6 \
  -num_glt 7 \
  -gltsym     "SYM: +.33*c_5_reward +.33*c_10_reward +.33*c_40_reward -.33*i_5_reward -.33*i_10_reward -.33*i_40_reward" \
  -glt_label 1 "cor-incor" \
  -gltsym     "SYM: +.5*i_5_reward +.5*c_5_reward" \
  -glt_label 2 "5_rew" \
  -gltsym     "SYM: +.5*i_10_reward +.5*c_10_reward" \
  -glt_label 3 "10_rew" \
  -gltsym     "SYM: +.5*i_40_reward +.5*c_40_reward" \
  -glt_label 4 "40_rew" \
  -gltsym     "SYM: +c_5_reward -i_5_reward" \
  -glt_label 5 "5_c-i" \
  -gltsym     "SYM: +c_10_reward -i_10_reward" \
  -glt_label 6 "10_c-i" \
  -gltsym     "SYM: +c_40_reward -i_40_reward" \
  -glt_label 7 "40_c-i" \


