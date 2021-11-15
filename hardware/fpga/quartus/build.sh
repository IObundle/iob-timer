#!/bin/bash
nios=$QUARTUSPATH/nios2eds/nios2_command_shell.sh

$nios quartus_sh -t ../timer.tcl "$1" "$2" "$3" "$4" "$5"
$nios quartus_map --read_settings_files=on --write_settings_files=off $1 -c $1
$nios quartus_fit --read_settings_files=off --write_settings_files=off $1 -c $1
$nios quartus_cdb --read_settings_files=off --write_settings_files=off $1 -c $1 --merge=on
$nios quartus_cdb iob_timer -c iob_timer --incremental_compilation_export=iob_timer_0.qxp --incremental_compilation_export_partition_name=Top --incremental_compilation_export_post_synth=on --incremental_compilation_export_post_fit=off --incremental_compilation_export_routing=on --incremental_compilation_export_flatten=on

