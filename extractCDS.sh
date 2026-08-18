#!/bin/bash -l
#SBATCH --get-user-env
#SBATCH --job-name=extractCDS
#SBATCH --output job%j.%N.out
#SBATCH --error job%j.%N.err
#SBATCH --cpus-per-task=8
#SBATCH -p defq #partition selection
#SBATCH --time=48:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=waddingm@email.sc.edu
#SBATCH --mem=24000

#here, TOL is our reference and SWB is our query
SWB=/work/waddingm/MimgutStandDraft_7/Mguttatusvar_SWB_988_v1.1.fa
TOL=/work/waddingm/v5.0/assembly/MguttatusTOL_551_v5.0.fa
ANNOTATION=/work/waddingm/v5.0/annotation/MguttatusTOL_551_v5.0.gene.gff3

cd /work/waddingm/tol_swb_align
conda activate /home/waddingm/.conda/envs/anchorwave_env

#Extract CDS
#this step makes a FASTA of CDS sequences from the annotation and reference genome
anchorwave gff2seq -i ${ANNOTATION} -r \
${TOL} -o cds.fa

#Mapping reference CDS to reference genome
#default p 0.8 N5, these settings are more permissive to start
minimap2 -x splice -a -t 10 -k 12 -p 0.4 -N 20 \
${TOL} cds.fa > ref.sam

#lift over to query genome
minimap2 -x splice -a -t 10 -k 12 -p 0.4 -N 20 \
${SWB} cds.fa > cds.sam