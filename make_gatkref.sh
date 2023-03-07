#! /bin/env/ bash

# Does not work on driver node (vaughn).
# Use qrsh or qsub.

#$ -cwd
#$ -S /bin/bash
#$ -N align
#$ -e mkdicterr
#$ -o mkdictout
#$ -q !gbs
# #$ -l mem_free=10G
#$ -V
# #$ -h
#$ -t 1-2:1

i=$(expr $SGE_TASK_ID - 1)

echo "PATH:"
echo $PATH
echo


# https://gatk.broadinstitute.org/hc/en-us/articles/360035531652-FASTA-Reference-genome-format

# All files will be created in the same directory as the reference.
#REF="ERBxHO40_23_hirisehap1.fa"
REF="../GCF_000146045.2_R64_genomic.fna"

GATK="~/bin/gatk4/gatk-4.1.4.1/gatk"
CMD="$GATK --java-options \"-Djava.io.tmpdir=/data/ -Xmx4g\" CreateSequenceDictionary \
   -R $REF"

echo $CMD
# eval $CMD

# CMD="~/bin/samtools-1.11/samtools faidx ERBxHO40_23_hirisehap1.fa"
CMD="~/bin/samtools-1.11/samtools faidx $REF"

echo $CMD
# eval $CMD


# EOF.
