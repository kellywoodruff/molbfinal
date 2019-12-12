#!/bin/bash
#SBATCH -J RAxML
#SBATCH -n 1
#SBATCH -t 30:00
#SBATCH --mem=20g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=klomagno@uwyo.edu

#SBATCH --ntasks-per-node=8
#SBATCH --account=cowusda2016

echo "Starting raxmlHPC run at $(date)"

module load swset gcc raxml

raxmlHPC-PTHREADS-AVX -T 8 -f a -m GTRGAMMA -p 618 -N 50 -x 309 -s known16s.aln -n 16sTree -w /home/klomagno/molbfinal/16sTree -o Ruminococcus_flavefaciens

echo "RAxML has finished at $(date)"
