#!/bin/bash

#$ -cwd
#$ -S /bin/bash
#$ -N bam_subset
#$ -e bam_subseterr
#$ -o bam_subsetout
#$ -q (hoser|bassil)
#$ -pe thread 3
# #$ -l mem_free=10G
#$ -V
# #$ -h
# $ -t 1-2:1 

#i=$(expr $SGE_TASK_ID - 1)

### The purpose of this script is to subset a portion of a bam file, specified by "X", from all files in the current working directory.###
### The subset along with an associated index (bai) will then be placed in a directory by the name specified by "Y".###
### As currently written, this will be run on hoser, if it is available. Default outputs for -err and -out can be changed above. ###

################################################
##CHANGE X and Y TO DESIRED LOCATION TO SUBSET##
################################################

#X="000049F|arrow"
X="000068F|arrow"

#Y="000049F"
Y="000068F"


mkdir ./$Y

for file_name in *.bam; do
    file_name="${file_name%%.*}"
    samtools view $file_name.bam $X -b > ./$Y/$file_name.sub$Y.bam
    samtools index ./$Y/$file_name.sub$Y.bam ./$Y/$file_name.sub$Y.bam.bai
done

printf "...and that's all, folks\041\n"

###For Reference Only###

###samtools view###
## samtools view – views and converts SAM/BAM/CRAM files
## -b, --bam	Output in the BAM format.
## -@ INT, --threads INT	Number of BAM compression threads to use in addition to main thread [0].

###samtools index###
## samtools index – indexes SAM/BAM/CRAM files
## -b	Create a BAI index. This is currently the default when no format options are used.
## -@, --threads INT	Number of input/output compression threads to use in addition to main thread [0].




#The previous code is based on this example:
#samtools view A1_S1.bam "000049F|arrow" -b > ./000049F/A1_S1sub49.bam
#samtools index ./000049F/A1_S1sub49.bam ./000049F/A1_S1sub49.bam.bai

## Explanation:
# The directory the example files are in was the result of a StringTie output, specifically there are 102 bam files named things like A1_S1.bam or F10_S78.bam.
# Each of those bam files is quite large, so downloading them all to a local machine from the Oregon State University infrastructure would take a lot of resources as well as a lot of time.
# The bam files contain many sections, in this case, the sections are contigs named things like "000049F|arrow" or "000068F|arrow". They might in other cases be chromosomes like "Chromosome 1".
# Making a bam file of just one of those sections (For each file in the original directory) would be much more manageable and easily downloaded to a local machine.
# The two lines of code above would search through all 102 bam files in the directory, looking for the section called "000049F|arrow". 
# This would then be extracted as a much smaller bam file called *sub49.bam, where the * would be replaced by the name of each of the original, very large bam files.
# The new subsetted files would be placed in a directory called 000049F, and would also be accompanied by bai index files: *sub49.bam.bai
# The section at the top of this file with #$ is all for giving instructions to qsub.

## To run this file, place it in the appropriate directory with the bam files to subset. Then write [Linux@vaughan ~]$ qsub bam_subsetter.sh