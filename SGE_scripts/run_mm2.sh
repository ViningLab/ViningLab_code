#!/bin/env bash

# Submit this script as follows.
# qsub run_mm2.sh

#$ -cwd
#$ -S /bin/bash
#$ -N mm2
#$ -e mm2err
#$ -o mm2out
#$ -q (hoser|bassil)
#$ -pe thread 3
# $ -pe thread 10
# $ -pe thread 20
# #$ -l mem_free=10G
#$ -V
# #$ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)


FA1="~/Vining_Lab_nfs3/GENOMES/hemp/CBDRx/GCF_900626175/GCF_900626175.2_cs10_genomic.fna"
FA2="~/Vining_Lab_nfs3/GENOMES/hemp/private_data/OregonCBD/ERBxHO40_23/pacbio_haps/ERBxHO40_23_COMBINED-Hap2.fasta"

MM2="~/bin/minmap2/minimap2-2.17_x64-linux/minimap2"

# -a           output in the SAM format (PAF by default)
# -c    output CIGAR in PAF
# -x    - asm5/asm10/asm20: asm-to-ref mapping, for ~0.1/1/5% sequence divergence
# -o FILE      output alignments to FILE [stdout] 
# -d FILE      dump index to FILE []
# -t INT       number of threads [3]

# Match threads with the SGE request above (#$ -pe thread)
NTHREADS=3

CMD="$MM2 -c -x asm5 -t $NTHREADS $FA1 $FA2 -o mm2_CBDRx_ERBxHO40_23_COMBINED-Hap2.paf"

date

echo $CMD
# eval $CMD

date


# EOF.
