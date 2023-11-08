#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N brkr2
#$ -e brkr2err
#$ -o brkr2out
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

# https://github.com/Gaius-Augustus/BRAKER
# which braker.pl
# BRAKER="/local/cluster/BRAKER-2.1.5/scripts/braker.pl"
# 
BRAKER="~/gits/BRAKER/scripts/braker.pl"

braker.pl -version

# Ideally a "soft masked" genome.
#GENOME="../repeatmodeler/GCF_000146045.2_R64_genomic.fna.masked"
#GENOME="~/Vining_Lab_nfs3/GENOMES/hemp/CBDRx/GCF_900626175/RepeatModeler/GCF_900626175.2_cs10_genomic.fna.masked"
#GENOME="../CBDRx_masked_nospace.fna"
#GENOME="GCF_900626175.2_cs10_genomic.fna_nospace.fasta"
#GENOME="../CBDRx_braker3/GCF_900626175.2_cs10_genomic.fna_nospace.fasta"
#GENOME="../braker_example/genome.fa"
#GENOME="../repeatmodeler/ERBxHO40_23_hirisehap1.masked"
#GNAME="ERBxHO40_23_hirisehap1b"
#GENOME="../repeatmodeler/CBR_1.asm.bp.hap1.p_ctg.gfa.fa.masked"
#GNAME="CBR_hap1b"

# GENOME="../RepeatModeler_softmask/GCA_003417725.2_ASM341772v2_genomic.fna.masked"
#GENOME="../RepeatModeler_softmask/GCA_003417725.2_ASM341772v2_genomic.fna_nospace.fasta"
#GNAME="Finola2"

#GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna.masked"
GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna_nospace.fasta"
GNAME="Purple_Kush2"

# HINTS="../braker_rna/braker/braker.gtf" # Includes unsupported features (e.g., start_codon, CDS, gene, transcript).
#HINTS="../braker_rna/braker/hintsfile.gff"
#HINTS="../prothint/prothint_augustus.gff"
#HINTS="../prothint/prothint_augustus.gff"
#HINTS="/nfs4/HORT/Vining_Lab/Users/knausb/CBDRx_braker2/prothint/prothint_augustus.gff"
#HINTS="braker2/prothint_augustus.gff"

# ORTHODB="../../OrthoDB/proteins_plants.fasta"

# PROT_SEQ="../braker_example/orthodb_small.fa"
# PROT_SEQ="../OrthoDB/proteins_plants_CBDRx.fasta"
# PROT_SEQ="~/Vining_Lab_nfs4/Users/knausb/OrthoDB/proteins_plants.fasta"
# PROT_SEQ="~/Vining_Lab_nfs4/Users/knausb/OrthoDB/proteins_plants_CBDRx.fasta"
# Does not like tilda expansion.
PROT_SEQ="/home/bpp/knausb/Vining_Lab_nfs4/Users/knausb/OrthoDB/proteins_plants_CBDRx.fasta"

##### ##### ##### ##### #####

echo
date

# export ALIGNMENT_TOOL_PATH=/local/cluster/ProtHint/bin
# 
export ALIGNMENT_TOOL_PATH=~/gits/ProtHint/bin
export PROTHINT_PATH=~/gits/ProtHint/bin

CMD="$BRAKER \
     --genome=$GENOME \
     --species=$GNAME \
     --prot_seq=$PROT_SEQ \
     --softmasking \
     --AUGUSTUS_CONFIG_PATH=/nfs4/HORT/Vining_Lab/Users/knausb/augustus_knausb/config/ \
     --epmode \
     --cores=8 \
     --workingdir=braker2"

# --gff3 flag does not appear to accomplish anything here.


#     --hints=$HINTS \
#     --ALIGNMENT_TOOL_PATH=/local/cluster/ProtHint/bin/ \
#        ALIGNMENT_TOOL_PATH=/local/cluster/ProtHint/bin


echo $CMD
eval $CMD

echo
date
echo

# EOF.
