#!/bin/bash

## USAGE: standardproc.sh subject id

subject=$1

PROJ_PATH=/data/home/tarazlee/DSP/$subject/reward/

cd $PROJ_PATH/afni_proc/
pwd
#source ~/.bashrc_MATT_source # need to source Matt's files for afni_proc
echo "starting afni_proc"
afni_proc.py \
  -bash \
  -script reward_3_level_proc_"$subject" \
  -out_dir "$subject".reward_3_level \
  -blocks mask regress  \
  -subj_id $subject \
  -dsets \
    "$subject".results/preproc.data/pb03."$subject".r*.scale+tlrc.HEAD \
  -scr_overwrite \
  -regress_basis GAM \
  -regress_stim_types times times times times times times \
                      times times times times times times \
                      AM1 AM1 AM1 AM1 AM1 AM1 \
                      AM1 AM1 AM1 AM1 AM1 AM1 \
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
    "$PROJ_PATH"behavior/"$subject"_correct_A_05_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_A_10_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_A_30_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_05_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_10_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_30_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_05_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_10_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_30_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_05_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_10_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_30_reward_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_A_05_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_A_10_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_A_30_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_05_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_10_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_30_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_05_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_10_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_30_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_05_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_10_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_30_move_onsets.txt \
   -regress_stim_labels \
    c_A_05_reward \
    c_A_10_reward \
    c_A_30_reward \
    c_B_05_reward \
    c_B_10_reward \
    c_B_30_reward \
    i_A_05_reward \
    i_A_10_reward \
    i_A_30_reward \
    i_B_05_reward \
    i_B_10_reward \
    i_B_30_reward \
    c_A_05_move \
    c_A_10_move \
    c_A_30_move \
    c_B_05_move \
    c_B_10_move \
    c_B_30_move \
    i_A_05_move \
    i_A_10_move \
    i_A_30_move \
    i_B_05_move \
    i_B_10_move \
    i_B_30_move \
  -regress_reml_exec \
  -test_stim_files no \
  -regress_opts_reml -GOFORIT \
  -regress_opts_CS -prefix ClustSimOutput \
  -regress_local_times \
  -regress_make_cbucket yes \
  -regress_opts_3dD \
  -GOFORIT 6 \
  -num_glt 13 \
  -gltsym     "SYM: +.1667*c_A_05_reward +.1667*c_A_10_reward +.1667*c_A_30_reward \
                +.1667*c_B_05_reward +.1667*c_B_10_reward +.1667*c_B_30_reward" \
  -glt_label 1 "c_reward" \
  -gltsym     "SYM: +.1667*c_A_05_move +.1667*c_A_10_move +.1667*c_A_30_move \
                +.1667*c_B_05_move +.1667*c_B_10_move +.1667*c_B_30_move" \
  -glt_label 2 "c_move" \
  -gltsym     "SYM: +.3333*c_A_05_reward +.3333*c_A_10_reward +.3333*c_A_30_reward \
                -.3333*c_B_05_reward -.3333*c_B_10_reward -.3333*c_B_30_reward" \
  -glt_label 3 "A-B_reward" \
  -gltsym     "SYM: +.3333*c_A_05_move +.3333*c_A_10_move +.3333*c_A_30_move \
                -.3333*c_B_05_move -.3333*c_B_10_move -.3333*c_B_30_move" \
  -glt_label 4 "A-B_move" \
  -gltsym     "SYM: +.5*c_A_10_reward +.5*c_B_10_reward -.5*c_A_05_reward -.5*c_B_05_reward" \
  -glt_label 5 "10-5_c_rew" \
  -gltsym     "SYM: +.5*c_A_30_reward +.5*c_B_30_reward -.5*c_A_05_reward -.5*c_B_05_reward" \
  -glt_label 6 "30-5_c_rew" \
  -gltsym     "SYM: +.5*c_A_30_reward +.5*c_B_30_reward -.5*c_A_10_reward -.5*c_B_10_reward" \
  -glt_label 7 "30-10_c_rew" \
  -gltsym     "SYM: +.5*i_A_10_reward +.5*i_B_10_reward -.5*i_A_05_reward -.5*i_B_05_reward" \
  -glt_label 8 "10-5_i_rew" \
  -gltsym     "SYM: +.5*i_A_30_reward +.5*i_B_30_reward -.5*i_A_05_reward -.5*i_B_05_reward" \
  -glt_label 9 "30-5_i_rew" \
  -gltsym     "SYM: +.5*i_A_30_reward +.5*i_B_30_reward -.5*i_A_10_reward -.5*i_B_10_reward" \
  -glt_label 10 "30-10_i_rew" \
  -gltsym     "SYM: +.5*c_A_05_reward +.5*c_B_05_reward -.5*i_A_05_reward -.5*c_B_05_reward" \
  -glt_label 11 "05_c-i_rew" \
  -gltsym     "SYM: +.5*c_A_10_reward +.5*c_B_10_reward -.5*i_A_10_reward -.5*c_B_10_reward" \
  -glt_label 12 "10_c-i_rew" \
  -gltsym     "SYM: +.5*c_A_30_reward +.5*c_B_30_reward -.5*i_A_30_reward -.5*c_B_30_reward" \
  -glt_label 13 "30_c-i_rew" \



