abinit_check.sh 1
abinit_check.sh 2
#rklist.sh 23 23 23 abinit # 328
rklist.sh 51 51 51 abinit # 3107
echo "2" > .peso1; cp .peso1 .peso2
run_tiniba.sh -r run -k 3107 -N 0 -x 2 -C 12 -P 100 -w -e -p
run_tiniba.sh -r run -k 3107 -N 0 -x 2 -C 12 -P 100 -s
all_responses.sh -w total -m 3107_10-spin -s 0.0 -o 1 -v 8 -c 24 -r 1 -t "xx"
all_responses.sh -w total -m 3107_10-spin -s 0.985 -o 1 -v 8 -c 24 -r 1 -t "xx"
all_responses.sh -w total -m 3107_10-spin -s 0.0 -o 1 -v 8 -c 24 -r 41 -t "xyz"
all_responses.sh -w total -m 3107_10-spin -s 0.985 -o 1 -v 8 -c 24 -r 41 -t "xyz"

