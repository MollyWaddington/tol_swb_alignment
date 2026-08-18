#!/bin/bash -l
#SBATCH --get-user-env
#SBATCH --job-name=align
#SBATCH --output job%j.%N.out
#SBATCH --error job%j.%N.err
#SBATCH --cpus-per-task=8
#SBATCH -p defq #partition selection
#SBATCH --time=48:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=waddingm@email.sc.edu
#SBATCH --mem=24000

source /home/apps/anaconda/3.12/etc/profile.d/conda.sh
conda activate /home/waddingm/.conda/envs/anchorwave_env

cd /work/waddingm/tol_swb_align

SWB=/work/waddingm/tol_swb_align/SWB.chr.fa
TOL=/work/waddingm/tol_swb_align/TOL.chr.fa
ANNOTATION=/work/waddingm/tol_swb_align/TOL.chr.gff3

anchorwave genoAli \
  -i "${ANNOTATION}" \
  -as cds.chr.fa \
  -r "${TOL}" \
  -a cds.chr.sam \
  -ar ref.chr.sam \
  -s "${SWB}" \
  -n anchors.chr \
  -o tol_swb.chr.maf \
  -f tol_swb.chr.f.maf