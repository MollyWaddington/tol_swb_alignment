# tol_swb_alignment
scripts for aligning TOL and SWB Mimulus guttatus reference genomes

This is where I will keep track of everything I do.

I am starting with the protocol from Wang, Xu, & Song et al., 2023 for using anchorwave.
https://bio-protocol.org/pdf/bio-protocol4830.pdf

to install anchorwave: 
conda install -c bioconda -c conda-forge anchorwave

1) extract reference CDS and lift over reference and query genome
script: extractCDS.sh 
This workflow does 3 things: it extracts the reference CDS from a genome annotation, maps those CDS beck to the reference and to a query genome with a splice-aware aligner.

2) alignment
script: align.sh
this script uses the genoali function to align the genomes
(might need to split this across multiple)