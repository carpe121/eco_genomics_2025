#!/bin/bash

### load modules

module purge
module load gcc angsd

### Set up directories and variables

IN="/users/m/c/mcarpen3/projects/eco_genomics_2025/final_proj"

DEST="/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers"

REF="/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ref_genome/Pmariana/Pmariana1.0-genome_reduced.fa.fai"

#= ASSOCIATION TEST =#

angsd -ybin ${IN}/assoc.ybin \
-doAsso 1 \
-bam ${IN}/final_bam.list \
-out ${DEST}/hotcon_asso_2 \
-GL 1 \
-fai ${REF} \
-doMajorMinor 1 \
-SNP_pval 1e-6 \
-doMaf 1

