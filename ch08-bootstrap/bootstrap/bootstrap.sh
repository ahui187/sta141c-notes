#!/bin/bash
#
#SBATCH --job-name=bootstrap
#SBATCH --output=bootstrap.out
#SBATCH --error=bootstrap.err
#SBATCH -p high2
#SBATCH -n 4
#SBATCH -t 1

module load R
srun Rscript bootstrap.R
