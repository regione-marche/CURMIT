#!/bin/bash
#_tmp_root=/usr/local/progetti/iter/iter25/sql/oracle
_tmp_root=.
sqlldr parfile=$_tmp_root/4-coim-load/load-common.ctl, control=$_tmp_root/4-coim-load/ctl/$1.ctl, data=$_tmp_root/file/$1.dat, log=$_tmp_root/4-coim-load/log/$1.log, bad=$_tmp_root/4-coim-load/bad/$1.bad, discard=$_tmp_root/4-coim-load/bad/$1.dsc
#if not errorlevel 0 pause
unset _tmp_root
