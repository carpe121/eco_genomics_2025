#!/bin/bash

# R #
# x <- read.table("/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/hotcon_fdr.tsv", header=T)
# y <- x %>% select(c(Chromosome, Position))
# y$End <- y$Position
# write_delim(y, "hotcon_bed.bed", col_names=FALSE, delim="\t")


module load gcc/13.3.0-xp3epyt
module load bedtools2/2.31.1-xip5kr5

cd /gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ref_genome/Pmariana/annotation/GO_annotations/

# GO Annotations
## /gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ref_genome/Pmariana/annotation/GO_annotations/Pmariana_GO_annotations_sorted_join.txt

# FDR-corrected genes
## /gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/hotcon_fdr.tsv

sed 's/\s/\t/g' Pmariana_GO_annotations_sorted_join.txt | cut -f 4,9,2,3 -d$'\t' | grep "JASDQ" > /gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/GO_forRS.bed

awk '{print $4, $1, $2, $3}' GO_forRS.bed > rearr_GORS.bed
sed 's/\s/\t/g' rearr_GORS.bed > tab_GORS.bed

bedtools intersect -loj -a hotconbed_fdr.bed -b tab_GORS.bed > RS_bt2


