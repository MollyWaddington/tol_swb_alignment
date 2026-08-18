# tol_swb_alignment
scripts for aligning TOL and SWB Mimulus guttatus reference genomes

This is where I will keep track of everything I do.

I am starting with the protocol from Wang, Xu, & Song et al., 2023 for using anchorwave.
https://bio-protocol.org/pdf/bio-protocol4830.pdf

to install anchorwave: 
conda install -c bioconda -c conda-forge anchorwave

** Note ** SWB and TOL have different chromosome names (Chr01 vs Chr_01). For anchorwave, the names *must* be the same, so change this first.

example:
sed -E 's/^>Chr([0-9]{2})/>Chr_\1/' \
  /work/waddingm/MimgutStandDraft_7/Mguttatusvar_SWB_988_v1.1.fa > Mguttatusvar_SWB_988_v1.1.renamed.fa

I also had to make new files containing *only* the  chromosome information, because having the 'scaffolds' was messing up the alignment

Here, I use TOL as the reference and SWB as the query, though I think both ways would work. The literature suggests using the genome with the highest quality annotations and most complete/contiguous assembly as the reference.

1) extract reference CDS and lift over reference and query genome
    
    script: extractCDS.sh 
    
    This script extracts the reference CDS (coding DNA sequence) from a genome annotation, maps those CDS beck to the reference and to a query genome with a splice-aware aligner.

CDS are the "anchors". Anchorwave reads the reference genome and the GFF3 annotation to pull out reference full-length coding sequences. It maps and lifts over the start and end positions of the CDS coordinates onto the query genome. The algorithm uses the matched CDS blocks to identify collinear anchor regions (conserved matching segments). Intervals between and within anchors are aligned to builf the final alignment blocks. 

2) alignment
    
    script: align.sh
    
    this script uses the genoali function to align the genomes

In anchorwave, proali and genoAli are distinct functions for aligning sequences. genoAli is designed for closely related accessions or species with minimal structural rearrangements, while proali is used for complex variations (translocations, chromosome fusions, and whole genome duplications) Because I am aligning two *M.guttatus* genomes, I chose to use genoAli, but for future projects proali might be more appropriate.

3) checking CDS output

CDS file:

grep -c '^>' cds.chr.fa

head -2 cds.chr.fa

*should be greater than 0*

grep '^>' cds.chr.fa | head

*should match gene ids in annotation*


mapping CDS to SWB (ref.sam):

*should be the alignments of the cds to TOL. because the cds came from TOL, the mappings should be good.*

grep -vc '^@' ref.chr.sam

*tells you how many alignment records exist*

awk '!/^@/ && $3!="*" {n++} END {print "mapped:", n}' ref.chr.sam

*number of mapped records. should be close to previous value*

awk '!/^@/ && $3!="*" {print $3}' ref.chr.sam | sort | uniq -c | sort -nr | head -20

*mappings per chromosome*


Mapping cds to SWB (cds.chr.sam)

grep -vc '^@' cds.chr.sam

awk '!/^@/ && $3!="*" {n++} END {print "mapped:", n}' cds.chr.sam

awk '!/^@/ && $3!="*" {print $3}' cds.chr.sam | sort | uniq -c | sort -nr | head -20

*hopefully, these numbers are similar to the previous numbers with TOL*

checking all chr are present:

awk '!/^@/ && $3!="*" {print $3}' cds.chr.sam | sort -u


4) checking alignment output
*check output exists*

ls -lh anchors.chr tol_swb.chr.maf tol_swb.chr.f.maf

*chromosome, start, aligned length, and chromosole length*

grep -E '^[[:space:]]*s[[:space:]]' tol_swb.chr.maf |
awk '{print $1, $2, $3, $4, $5, $6}' |
head -30


confirm:
14 alignment blocks
28 sequence records
14 TOL chromosomes
14 SWB chromosomes

and every chromosome has
start = 0
aligned size = chromosome length
