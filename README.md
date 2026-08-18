# tol_swb_alignment
scripts for aligning TOL and SWB Mimulus guttatus reference genomes

This is where I will keep track of everything I do.

I am starting with the protocol from Wang, Xu, & Song et al., 2023 for using anchorwave.
https://bio-protocol.org/pdf/bio-protocol4830.pdf

to install anchorwave: 
conda install -c bioconda -c conda-forge anchorwave

** Note ** SWB and TOL have different chromosome names (Chr01 vs Chr_01) for anchorwave, the names *must* be the same, so change this first.

example:
sed -E 's/^>Chr([0-9]{2})/>Chr_\1/' \
  /work/waddingm/MimgutStandDraft_7/Mguttatusvar_SWB_988_v1.1.fa > Mguttatusvar_SWB_988_v1.1.renamed.fa

I also had to make new files containing only the  chromosome information, because having the 'scaffolds' was messing up the alignment

1) extract reference CDS and lift over reference and query genome
script: extractCDS.sh 
This workflow does 3 things: it extracts the reference CDS from a genome annotation, maps those CDS beck to the reference and to a query genome with a splice-aware aligner.

2) alignment
script:sq align.sh
this script uses the genoali function to align the genomes
(might need to split this across multiple)