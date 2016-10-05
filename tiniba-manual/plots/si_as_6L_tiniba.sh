#!/bin/bash
abinit_check.sh 1
abinit_check.sh 2
rklist.sh 21 21 2 abinit
rlayer.sh 4.788090 1 4 1 1
zmesh.pl 25 50
head -n `wc -l .machines_pmn.original | awk '{ print $1 }'` si_as_6.klist_44 > si_as_6.klist_rho
run_tiniba.sh -r run -k rho -N 6 -x 2 -m
