#!/usr/bin/bash
export ALTERAPATH=/home/iobundle/Intel/Altera_full/18.0
export LM_LICENSE_FILE=1801@localhost:$ALTERAPATH/../1-MVXX5H_License.dat
nios=/home/iobundle/Intel/Altera_full/18.0/nios2eds/nios2_command_shell.sh

TOP_MODULE="iob_timer"

$nios quartus_sh -t ../timer.tcl "$1" "$2" "$3"
$nios quartus_map --read_settings_files=on --write_settings_files=off $TOP_MODULE -c $TOP_MODULE
$nios quartus_fit --read_settings_files=off --write_settings_files=off $TOP_MODULE -c $TOP_MODULE
$nios quartus_cdb --read_settings_files=off --write_settings_files=off $TOP_MODULE -c $TOP_MODULE --merge=on
$nios quartus_cdb iob_timer -c iob_timer --incremental_compilation_export=iob_timer_0.qxp --incremental_compilation_export_partition_name=Top --incremental_compilation_export_post_synth=on --incremental_compilation_export_post_fit=off --incremental_compilation_export_routing=on --incremental_compilation_export_flatten=on

