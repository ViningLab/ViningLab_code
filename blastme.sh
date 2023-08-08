#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N blst
#$ -e blsterr
#$ -o blstout
#$ -q hoser
# $ -pe thread 4
# $ -pe thread 10
# $ -pe thread 20
# #$ -l mem_free=10G
#$ -V
# $ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####

# 
DB="~/Vining_Lab_nfs3/GENOMES/hemp/CBDRx/GCF_900626175/blastdb_genomic/CBDRx"
# OUTF="cann5S_CBDRx_blastn.csv"
# 
OUTF="cann_motif_CBDRx_blastn.csv"

#DB="~/Vining_Lab_nfs3/GENOMES/hemp/Finola/GCA_003417725.2/blastdb_genomic/Finola"
#OUTF="cann5S_Finola_blastn.csv"

##### ##### ##### ##### #####

# QUERY="probes_cann5S.fa"
QUERY="cann_motif_probes.fa"

#BLAST="~/bin/ncbi-blast-2.2.26+/bin/blastn"
#BLAST="~/bin/ncbi-blast-2.12.0+/bin/blastn"
BLAST="/local/cluster/ncbi-blast+/bin/blastn"

CMD="$BLAST -query $QUERY \
            -task megablast \
            -db $DB \
            -evalue 0.001 \
            -num_alignments 10 \
            -perc_identity 90 \
            -qcov_hsp_perc 90 \
            -num_threads 1 \
            -mt_mode 1 \
            -outfmt '10 qseqid qlen sseqid slen qstart qend sstart send evalue bitscore score length pident nident mismatch positive gapopen gaps ppos sstrand sseq' > $OUTF"

echo $CMD
#
eval $CMD


# EOF.
