#!/bin/bash -l
#SBATCH --get-user-env
#SBATCH --job-name=align
#SBATCH --output job%j.%N.out
#SBATCH --error job%j.%N.err
#SBATCH --cpus-per-task=8
#SBATCH -p defq #partition selection
#SBATCH --time=48:00:00
#SBATCH --mail-type=ALL          # Type of email notification: BEGIN,END,FAIL,A$
#SBATCH --mail-user=waddingm@email.sc.edu  #Email where notifications will be sent
#SBATCH --mem=24000

SWB=/work/waddingm/MimgutStandDraft_7/Mguttatusvar_SWB_988_v1.1.fa
TOL=/work/waddingm/v5.0/assembly/MguttatusTOL_551_v5.0.fa
ANNOTATION=/work/waddingm/v5.0/annotation/MguttatusTOL_551_v5.0.gene.gff3

anchorwave genoAli -i ${ANNOTATION} -as cds.fa -r \
${TOL} -a cds.sam -ar ref.sam -s Zm-Mo17- \
${SWB} -n anchors.anchors -o tol_swb.maf -f \
tol_swb.f.maf -IV