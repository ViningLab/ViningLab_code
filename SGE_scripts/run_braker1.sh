#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N brkr1
#$ -e brkr1err
#$ -o brkr1out
#$ -q hoser
#$ -pe thread 8
# $ -pe thread 16
# $ -pe thread 10
# #$ -l mem_free=10G
#$ -V
# #$ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####

# http://daehwankimlab.github.io/hisat2/
# https://github.com/DaehwanKimLab/hisat2

# Run RNA_bam and OrthoDB (FASTA) seperately
# Then combine both runs with TSEBRA.

# To run with protein sequences
#
# braker.pl [OPTIONS] --genome=genome.fa --species=speciesname \
#     --prot_seq=proteins.fa
# braker.pl [OPTIONS] --genome=genome.fa --species=speciesname \
#     --hints=prothint_augustus.gff


# https://github.com/Gaius-Augustus/BRAKER
# which braker.pl
BRAKER="/local/cluster/BRAKER-2.1.5/scripts/braker.pl"

braker.pl -version

# Ideally a "soft masked" genome.
#GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna.masked"
GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna_nospace.fasta"
GNAME="Purple_Kush1"

RNASEQ_bam="../RNA_evidence/bams/SRR10600876_sorted.bam,../RNA_evidence/bams/SRR10600883_sorted.bam,../RNA_evidence/bams/SRR10600884_sorted.bam,../RNA_evidence/bams/SRR10600886_sorted.bam,../RNA_evidence/bams/SRR10600901_sorted.bam,../RNA_evidence/bams/SRR10600927_sorted.bam,../RNA_evidence/bams/SRR10600944_sorted.bam"

##### ##### ##### ##### #####

# Get fresh ~/.gm_key at below link (fill out form for download link).
# http://exon.gatech.edu/GeneMark/license_download.cgi

echo
date

CMD="$BRAKER \
     --species=$GNAME \
     --genome=$GENOME \
     --bam=$RNASEQ_bam \
     --AUGUSTUS_CONFIG_PATH=/nfs4/HORT/Vining_Lab/Users/knausb/augustus_knausb/config/ \
     --BAMTOOLS_PATH=/local/cluster/bamtools/bin/ \
     --softmasking \
     --cores=8 \
     --workingdir=braker1"

echo $CMD
eval $CMD

echo
date
echo


# EOF.
