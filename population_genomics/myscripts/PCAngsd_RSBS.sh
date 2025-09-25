#!/bin/bash

#SBATCH --job-name=PCA_ANG
#SBATCH --output=/users/m/c/mcarpen3/projects/eco_genomics_2025/population_genomics/mylogs/%x_%j.out
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=24:00:00

# load modules
module purge
module load pcangsd/1.36.1

# Path to your input data (where the beagle file lives)

INPUT="/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ANGSD"

# Make directory and set path to save your output (in your repo):

#mkdir ~/m/c/mcarpen3/projects/eco_genomics_2025/population_genomics/myresults/ANGSD/PCA_ADMIX

OUT="/users/m/c/mcarpen3/projects/eco_genomics_2025/population_genomics/myresults/ANGSD/PCA_ADMIX"

SUFFIX="RSBS_poly"

# Make a copy of the list of bam files for all the red + black spruce samples and place in your repo. You'll need this later for making figures.

cp ${INPUT}/RSBS_bam.list ${OUT}

# Set value of K and number of PCA eigenvalues (=K-1)
# K corresponds to the number of distinct ancestry groups you want to cluster genotypes into

K=2
E=$((K-1))

# Then, run PCA and admixture scores with pcangsd:

pcangsd -b ${INPUT}/${SUFFIX}.beagle.gz \
        -o ${OUT}/${SUFFIX}_K${K} \
        -e $E \
        --admix \
        --admix-K $K \
        --maf 0.05 \
        --threads 10
