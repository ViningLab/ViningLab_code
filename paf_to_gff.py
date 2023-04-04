#! /usr/bin/env python3

import argparse
import ntpath
import os


##### ##### ##### ##### #####
# Links and background.

# https://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md
# https://software.broadinstitute.org/software/igv/GFF
# https://docs.python.org/3/tutorial/
# https://docs.python.org/3/howto/argparse.html#id1

# https://github.com/lh3/miniasm/blob/master/PAF.md
# https://cran.r-project.org/web/packages/pafr/vignettes/Introduction_to_pafr.html

##### ##### ##### ##### #####
#
# argparse.
#
##### ##### ##### ##### #####


parser = argparse.ArgumentParser(description='Add a prefix to FASTA header lines. Requires python >=3.7.3.')
parser.add_argument("INFILE", help="File containing comma delimited data.")
#parser.add_argument("Threshold", metavar='N', type=int,
#                    help='an integer for the accumulator', default = 50)
#parser.add_argument("--Threshold", metavar='N', nargs='?', const=50, type=int, 
#    default = 50, help = "Minimum number of records to process.")
#parser.add_argument("NEW", nargs="?", const=1, default='_', help="New string to replace to FASTA header lines.")
parser.add_argument("-t", "--THRESHOLD", type=int, help="minimum length of match to return.",
                    default = 0)
parser.add_argument("-m", "--MAPQ", type=int, help="minimum mapq of match to return.",
                    default = 0)
#parser.add_argument('-e', '--example', nargs='?', const=1, type=int)
parser.add_argument("-v", "--verbose", help="increase output verbosity",
                    action="store_true")
                    
args = parser.parse_args()


##### ##### ##### ##### #####
#
# Main.
#
##### ##### ##### ##### #####

if args.verbose:
    print("verbosity turned on")


if args.verbose:
    print("Input file: " + args.INFILE)


# Manage outfile.

outfile = ntpath.basename(args.INFILE)
outfile = os.path.splitext(outfile) 

outfile = outfile[0]
outfile = outfile + '.gff'

if args.verbose:
    print("Output file: " + outfile)


f2 = open(outfile,'w')
f2.write("##gff-version 3")
f2.write("\n")
f2.write("# paf_to_gff.py")
f2.write(" -t ")
f2.write(str(args.THRESHOLD))
f2.write(" -m ")
f2.write(str(args.MAPQ))
f2.write(" ")
f2.write(args.INFILE)
f2.write("\n")
f2.write("# ['seqid', 'source', 'type', 'start', 'end', 'score', 'strand', 'phase', 'attributes']")
f2.write("\n")
f2.write("# c('seqid', 'source', 'type', 'start', 'end', 'score', 'strand', 'phase', 'attributes']")
f2.write("\n")

with open(args.INFILE) as f:
    for line in f:
        #print(line)
        # ['qname', 'qlen', 'qstart', 'qend', 
        # 'strand', 'tname', 'tlen', 'tstart', 'tend',
        # 'nmatch', 'alen', 'mapq']
        line = line.rstrip()
        myline = line.split("\t")
        if int(myline[8]) - int(myline[7]) >= args.THRESHOLD and int(myline[11]) >= args.MAPQ :
            f2.write(myline[5])
            f2.write("\t")
            f2.write('minimap2')
#        f2.write('minimap2>paf_to_gff')
            f2.write("\t")
#        f2.write('.')
            f2.write('match')
            f2.write("\t")
            # PAF is zero based, GFF is one based.
            f2.write( str(int(myline[7]) + 1))
            f2.write("\t")
            f2.write( str(int(myline[8]) + 1))
            f2.write("\t")
            f2.write('.')
#        f2.write("\t")
#        f2.write('.')
            f2.write("\t")
            f2.write(myline[4])
            f2.write("\t")
            f2.write('.')
            f2.write("\t")
            f2.write('qname=')
            f2.write(myline[0])
            f2.write(';qlen=')
            f2.write(myline[1])
            f2.write(';qstart=')
            f2.write(myline[2])
            f2.write(';qend=')
            f2.write(myline[3])
            f2.write(';strand=')
            f2.write(myline[4])
            f2.write(';tname=')
            f2.write(myline[5])
            f2.write(';tlen=')
            f2.write(myline[6])
            f2.write(';tstart=')
            f2.write(myline[7])
            f2.write(';tend=')
            f2.write(myline[8])
            f2.write(';nmatch=')
            f2.write(myline[9])
            f2.write(';alen=')
            f2.write(myline[10])
            f2.write(';mapq=')
            f2.write(myline[11])
            f2.write(';color=#EE0000')
            f2.write("\n")





# EOF.
