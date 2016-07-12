#!/bin/bash

## USAGE: standardproc.sh subject id

subject=$1

PROJ_PATH=/data/home/tarazlee/DSP/$subject/training/

cd $PROJ_PATH/afni_proc/
pwd
#source ~/.bashrc_MATT_source # need to source Matt's files for afni_proc
echo "starting afni_proc"
afni_proc.py \
  -bash \
  -script training_proc_"$subject" \
  -out_dir "$subject".training \
  -blocks mask regress  \
  -subj_id $subject \
  -dsets \
    "$subject".results/preproc.data/pb03."$subject".r*.scale+tlrc.HEAD \
  -scr_overwrite \
  -regress_basis GAM \
  -regress_stim_types times times times times times times \
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
    "$PROJ_PATH"behavior/"$subject"_correct_A_cue_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_cue_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_rand_cue_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_cue_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_cue_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_rand_cue_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_A_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_B_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_correct_rand_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_A_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_B_move_onsets.txt \
    "$PROJ_PATH"behavior/"$subject"_incorrect_rand_move_onsets.txt \
   -regress_stim_labels \
    c_A_cue \
    c_B_cue \
    c_rand_cue \
    i_A_cue \
    i_B_cue \
    i_rand_cue \
    c_A_move \
    c_B_move \
    c_rand_move \
    i_A_move \
    i_B_move \
    i_rand_move \
  -regress_reml_exec \
  -test_stim_files no \
  -regress_opts_reml -GOFORIT \
  -regress_opts_CS -prefix ClustSimOutput \
  -regress_local_times \
  -regress_make_cbucket yes \
  -regress_opts_3dD \
  -GOFORIT 6 \
  -num_glt 8 \
  -gltsym     "SYM: +.333*c_A_cue +.333*c_B_cue +.333*c_rand_cue" \
  -glt_label 1 "c_cue" \
  -gltsym     "SYM: +.333*c_A_move +.333*c_B_move +.333*c_rand_move" \
  -glt_label 2 "c_move" \
  -gltsym     "SYM: +.25*c_A_cue +.25*i_A_cue +.25*c_B_cue +.25*i_B_cue -.5*c_rand_cue -.5*i_rand_cue" \
  -glt_label 3 "ab-rand_cue" \
  -gltsym     "SYM: +.25*c_A_move +.25*i_A_move +.25*c_B_move +.25*i_B_move -.5*c_rand_move -.5*i_rand_move" \
  -glt_label 4 "ab-rand_move" \
  -gltsym     "SYM: +.5*c_A_cue +.5*i_A_cue -.5*c_B_cue -.5*i_B_cue" \
  -glt_label 5 "A-B_cue" \
  -gltsym     "SYM: +.5*c_A_move +.5*i_A_move -.5*c_B_move -.5*i_B_move" \
  -glt_label 6 "A-B_move" \
  -gltsym     "SYM: +.5*c_A_cue +.5*c_B_cue -.5*i_A_cue -.5*i_B_cue" \
  -glt_label 7 "c-i_cue" \
  -gltsym     "SYM: +.5*c_A_move +.5*c_B_move -.5*i_A_move -.5*i_B_move" \
  -glt_label 8 "c-i_move" \




