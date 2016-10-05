echo "2" > .peso1; cp .peso1 .peso2
abinit_check.sh 1
abinit_check.sh 2
odd_rank.sh
rklist.sh 13 13 2 abinit
rlayer.sh 4.788090 1 4 1 1
chose_layers.sh half-slab
run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -w -e -p
run_tiniba.sh -r run -k 31 -N half-slab -x 2 -C 4 -P 75 -c
chose_layers.sh 6
run_tiniba.sh -r run -k 31 -N 6 -x 2 -C 4 -P 75 -c
all_responses.sh -w total -m 31_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 1 -t "xx yy zz"
all_responses.sh -w total -m 31_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 21 -t "xxx"
all_responses.sh -w layer -m 31_half-slab_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 24 -t "xx yy zz"
all_responses.sh -w layer -m 31_half-slab_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 44 -t "xxx"
all_responses.sh -w layer -m 31_1_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 24 -t "xx yy zz"
all_responses.sh -w layer -m 31_1_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 44 -t "xxx"
all_responses.sh -w layer -m 31_2_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 24 -t "xx yy zz"
all_responses.sh -w layer -m 31_2_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 44 -t "xxx"
all_responses.sh -w layer -m 31_3_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 24 -t "xx yy zz"
all_responses.sh -w layer -m 31_3_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 44 -t "xxx"
all_responses.sh -w layer -m 31_4_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 24 -t "xx yy zz"
all_responses.sh -w layer -m 31_4_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 44 -t "xxx"
all_responses.sh -w layer -m 31_5_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 24 -t "xx yy zz"
all_responses.sh -w layer -m 31_5_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 44 -t "xxx"
all_responses.sh -w layer -m 31_6_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 24 -t "xx yy zz"
all_responses.sh -w layer -m 31_6_03-nospin -s 0.5 -o 1 -v 13 -c 17 -r 44 -t "xxx"
