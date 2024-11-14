#!/usr/bin/env bash

# Run from files.cqls.oregonstate.edu

# nohup bash get_sra.sh &


RUNS=(
"SRR12831863"
"SRR12831864"
"SRR12831865"
"SRR12831866"
"SRR12831867"
"SRR12831868"
"SRR12831869"
"SRR12831870"
"SRR12831871"
"SRR12831872"
"SRR12831873"
"SRR12831874"
"SRR12831875"
"SRR12831876"
"SRR12831877"
)


# for i in $(seq 0 1);
for i in $(seq 0 13);
#for i in $(seq 0 14);
do
#    echo $i
  CMD="fasterq-dump \
    --outdir . \
    --temp . \
    --threads 1 \
    --split-files \
    ${RUNS[$i]}"

  echo $CMD
  eval $CMD

done

#  --progress \

# There does not appear to be an option for fasterq-dump 
# to gzip the FASTQ files.
# Use 'gzip *fastq' to gzip the FASTQ files after download.


# EOF.
