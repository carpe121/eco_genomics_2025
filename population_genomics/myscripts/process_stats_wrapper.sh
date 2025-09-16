#!/bin/bash

#SBATCH --job-name=bam_wrapper
#SBATCH --output=/users/m/c/mcarpen3/projects/eco_genomics_2025/population_genomics/mylogs/%x_%j.out
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64
#SBATCH --time=24:00:00

cd /gpfs1/home/m/c/mcarpen3/projects/eco_genomics_2025/population_genomics/myscripts

bash process_bam.sh
bash bam_stats.sh