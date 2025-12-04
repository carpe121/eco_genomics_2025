#!/bin/bash

#SBATCH --job-name=hotcon_asso
#SBATCH --output=/users/m/c/mcarpen3/projects/eco_genomics_2025/final_proj/mylogs/%x_%j.out
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=24:00:00

cd /gpfs1/home/m/c/mcarpen3/projects/eco_genomics_2025/final_proj

bash asso.sh
