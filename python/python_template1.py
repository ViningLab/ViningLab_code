#!/usr/bin/env python3

# https://docs.python.org/3/tutorial/
# https://docs.python.org/3/howto/argparse.html#id1
import argparse
import ntpath
import os

##### ##### ##### ##### #####

parser = argparse.ArgumentParser(description='Template for python.')
parser.add_argument("INFILE", help="Input file.")
parser.add_argument("-v", "--verbose", help="increase output verbosity",
                    action="store_true")

args = parser.parse_args()


##### ##### ##### ##### #####

# Remove PATH from infile.
ONAME = os.path.basename(args.INFILE)

# Remove extension from filename.
ONAME = os.path.splitext(ONAME)  # returns ('/home/user/somefile', '.txt')
ONAME = ONAME[0] + '_outfile.txt'

if args.verbose:
    print("args.INFILE:", args.INFILE)
    


with open(args.INFILE) as file:
    for line in file:
        print(line.rstrip())

file.close()



fout = open(ONAME, 'w', encoding="utf-8")

my_string = "Hello world!\n"

fout.write(my_string)

fout.close()



# EOF.
