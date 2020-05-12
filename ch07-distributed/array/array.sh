#!/bin/bash
#
#SBATCH --job-name=myjob
#SBATCH --output=array_%A_%a.out
#SBATCH --error=array_%A_%a.err
#SBATCH --array=1-8
#SBATCH -p high2
#SBATCH -n 1
#SBATCH -t 1

module load R
srun Rscript onejob.R
