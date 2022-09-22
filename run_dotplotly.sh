
# https://bioinformaticsworkbook.org/dataWrangling/genome-dotplots.html#gsc.tab=0
# https://github.com/tpoorten/dotPlotly

# -i input filename
# -o output filename
# -v verbose
# -q min-query-length
# -m min-alignment-length
# -p plot size in inches
# -l show horizontal lines
# -k number-ref-chromosomes
# -s turn on color alignments by % identity
# -t turn on calculation of % identity for on-target alignments only
# -x turn off production of interactive plotly
# -r comma-separated list of reference IDs to keep


#~/gits/dotPlotly/pafCoordsDotPlotly.R \
#   -i CBDRX_ERBxHO40_23_dovetail_hap1.paf \
#   -o CBDRX_ERBxHO40_23_dovetail_hap1.plot \
#   -m 2000 \
#   -q 500000 \
#   -k 10 \
#   -x \
#   -s -t -l -p 12

~/gits/dotPlotly/pafCoordsDotPlotly.R \
   -i CBDRX_Cannbio-2.paf \
   -o CBDRX_Cannbio-2.plot \
   -m 2000 \
   -q 500000 \
   -k 10 \
   -x \
   -s -t -l -p 12


#~/gits/dotPlotly/pafCoordsDotPlotly.R \
#   -i mm2_CBDRx_ERBxHO40_23_COMBINED-Hap2.paf \
#   -o CBDRx_ERBxHO40_23_COMBINED-Hap2_ref.plot \
#   -m 2000 \
#   -q 500000 \
#   -k 10 \
#   -r NC_044372.1 \
#   -r NC_044375.1,NC_044372.1,NC_044373.1 \
#   -s -t -l -p 12

# EOF
