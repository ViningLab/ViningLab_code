#! /bin/env bash

# Submit this script as follows.
# qsub run_hifiasm.sh

#$ -cwd
#$ -S /bin/bash
#$ -N asm
#$ -e asmerr
#$ -o asmout
#$ -q hoser
# $ -pe thread 4
#$ -pe thread 16
# $ -pe thread 10
# $ -pe thread 20
# #$ -l mem_free=10G
#$ -V
# $ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)


HIFIASM="/local/cluster/bin/hifiasm"

# Usage: hifiasm [options] <in_1.fq> <in_2.fq> <...>
# -o STR       prefix of output files [hifiasm.asm]
# -t INT       number of threads [1]
# --primary    output a primary assembly and an alternate assembly
# --n-hap      INT number of haplotypes [2]

CMD="$HIFIASM -o rice_hifiasm -t 16 --n-hap 2 ../m64013e_210227_222017.hifi_reads.fastq.gz"

date

echo $CMD
#
eval $CMD

date

# EOF.
