#!/bin/bash

#SBATCH --job-name=ANGSD_Fst
#SBATCH --output=/users/m/c/mcarpen3/projects/eco_genomics_2025/population_genomics/mylogs/%x_%j.out
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=24:00:00

# Uses ANGSD to estimate Fst between my red spruce pop
# and black spruce from outside the range

# load modules
module purge
module load gcc angsd

# Path to the `population_genomics` folder in your repo
REPO="/gpfs1/home/m/c/mcarpen3/projects/eco_genomics_2025/population_genomics"

# Path to the Black Spruce (BS) input saf.idx data (I made this file for you using the ANGSD.sh script)

BLKSPR="/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ANGSD/black_spruce"

# Make directory in `myresults/ANGSD` to store your results

#mkdir ${REPO}/myresults/ANGSD/Fst

MYBSPOP="WISC"

MYRSPOP="2019"

SUFFIX="ALL"

### Estimate Fst between my red spruce pop and black spruce:

# Step 1: estimate the 2D site frequency spectrum for BS and your RS pop
realSFS \
${REPO}/mydata/ANGSD/${MYRSPOP}_${SUFFIX}.saf.idx \
${BLKSPR}/${MYBSPOP}_${SUFFIX}.saf.idx \
>${REPO}/myresults/ANGSD/Fst/${MYRSPOP}_${MYBSPOP}_2D.sfs \
-P 10

# Step 2: Calculate Fst for all SNPs and store it in a binary format (.fst.idx)
realSFS fst index \
${REPO}/mydata/ANGSD/${MYRSPOP}_${SUFFIX}.saf.idx \
${BLKSPR}/${MYBSPOP}_${SUFFIX}.saf.idx \
-sfs ${REPO}/myresults/ANGSD/Fst/${MYRSPOP}_${MYBSPOP}_2D.sfs \
-fstout ${REPO}/mydata/ANGSD/${MYRSPOP}_${MYBSPOP} \
-whichFst 1 \
-P 10

# Step 3: Caclulate the average Fst across all sites (we use the weighted average)
realSFS fst stats \
${REPO}/mydata/ANGSD/${MYRSPOP}_${MYBSPOP}.fst.idx \
>${REPO}/myresults/ANGSD/Fst/${MYRSPOP}_${MYBSPOP}_Fst.txt \
-P 10

# Step 4 (optional): Calculate the averate Fst in sliding windows
realSFS fst stats2 \
${REPO}/mydata/ANGSD/${MYRSPOP}_${MYBSPOP}.fst.idx \
-win 50000 \
-step 50000 \
>${REPO}/myresults/ANGSD/Fst/${MYRSPOP}_${MYBSPOP}_Fst_50kbWindows.txt \
-P 10
