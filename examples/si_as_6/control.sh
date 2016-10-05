#!/bin/bash

mode="$1"
spin="$2"

inputfile="setUpAbinit_si_as_6.in"
responses="yes"
scissors="0.0"

sopspln=`grep -n "so_psp" setUpAbinit_si_as_6.in | awk -F: '{print $1}'`
nspinorln=`grep -n "nspinor" setUpAbinit_si_as_6.in | awk -F: '{print $1}'`

if [[ $spin == "spin" ]]; then
    sed -i 's|/home/sma/tiniba/pseudopotentials/pspnc/14si.pspnc|/home/sma/tiniba/pseudopotentials/hgh/14si.4.hgh|g' $inputfile
    sed -i 's|/home/sma/tiniba/pseudopotentials/pspnc/33as.pspnc|/home/sma/tiniba/pseudopotentials/hgh/33as.5.hgh|g' $inputfile
    sed -i "${sopspln}s/.*/so_psp         2 2/" $inputfile
    sed -i "${nspinorln}s/.*/nspinor        2 2/" $inputfile
else
    spin=nospin
    sed -i 's|/home/sma/tiniba/pseudopotentials/hgh/14si.4.hgh|/home/sma/tiniba/pseudopotentials/pspnc/14si.pspnc|g' $inputfile
    sed -i 's|/home/sma/tiniba/pseudopotentials/hgh/33as.5.hgh|/home/sma/tiniba/pseudopotentials/pspnc/33as.pspnc|g' $inputfile
    sed -i "${sopspln}s/.*/#so_psp         2 2/" $inputfile
    sed -i "${nspinorln}s/.*/#nspinor        2 2/" $inputfile
fi

if [[ "$mode" == "run" ]]; then
    echo "2" > .peso1; cp .peso1 .peso2
    abinit_check.sh 1
    abinit_check.sh 2
    odd_rank.sh
    rklist.sh 13 13 2 abinit
    rlayer.sh 4.788090 1 4 1 1
    chose_layers.sh half-slab
    if [[ $spin == "spin" ]]; then
        run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -w -e -p -s
        run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -c 
        run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -n
    else
        run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -w -e -p 
        run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -c 
        run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -v
        run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -V
    fi
    if [[ $responses == "yes" ]]; then
        all_responses.sh -w total -m 31_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 1 -t "xx yy zz"
        all_responses.sh -w total -m 31_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 3 -t "xxz"
        all_responses.sh -w total -m 31_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 27 -t "xx"
        all_responses.sh -w total -m 31_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 21 -t "xxx"
        all_responses.sh -w total -m 31_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 42 -t "xxx" 
        all_responses.sh -w layer -m 31_half-slab_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 24 -t "xx yy zz"
        all_responses.sh -w layer -m 31_half-slab_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 44 -t "xxx"
        all_responses.sh -w layer -m 31_half-slab_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 25 -t "xxz"
        #all_responses.sh -w layer -m 31_half-slab_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 26 -t "xx"
        if [[ $spin == "spin" ]]; then
            all_responses.sh -w total -m 31_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 41 -t "xyz"
            all_responses.sh -w layer -m 31_half-slab_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 29 -t "xyz"
        else
            all_responses.sh -w total -m 31_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 21 -t "xxx" -n
            all_responses.sh -w layer -m 31_half-slab_03-${spin} -s $scissors -o 1 -v 13 -c 17 -r 44 -t "xxx" -n
        fi
    fi
elif [[ "$mode" == "clean" ]]; then
    run_tiniba.sh -r erase
    run_tiniba.sh -r erasescf
    rm -rf .ab_layers.d .acell.d .back.layers back.layers.xy .cores eigen_* .fnval .front.layers front.layers.xy half_slab.* hoy* .i* layers.d* .lista_layers logfiles/ .machines_pmn .machines_scf .machines_latm .machines_res me_* mtita opt.dat .peso* si_as_6_* *.klist* si_as_6.xyz.original spin_info symmetries/ tmp* .trueMachines dp-vnl*
fi
