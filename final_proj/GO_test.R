library(tidyverse)

setwd("/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/")

z <- read.table("/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ref_genome/Pmariana/annotation/GO_annotations/Pmariana_GO_annotations_sorted_join.txt", header=F, fill=T)
z_new <- z %>% mutate(V7=ifelse(V7 %in% "", V2,V7))
colnames(z_new) <- c("gene", "start", "stop", "geneID", "strand", "parent", "marker")

x <- read.table("/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/RS_bt2", header=F)
x2 <- x %>% select(V1)
colnames(x2) <- c("marker")

xinner <- merge(x2, z_new, by="marker")
ab <- xinner %>% filter(grepl("Ontology", gene))
ab$gene <- gsub("Ontology_term=", '', ab$gene)
ab$gene <- gsub(",", ", ", ab$gene)

#write.table(ab, "GO_table_spruce.tsv", sep="\t", col.names=TRUE, quote=FALSE)

colnames(x) <- c("Chromosome", "Start", "Stop", "Gene")
fdr <- read.table("/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/hotcon_fdr.tsv", header=T)
fdr_subs <- fdr %>% select(Chromosome, qval)

fdr_sig <- merge(x, fdr_subs, by="Chromosome") #takes about 1 minute to merge
fdr_merge <- fdr_sig %>%
  arrange(qval) %>%
  select(Chromosome, qval)
fdr_select <- head(fdr_merge, n=1000)

colnames(ab)[1] <- "Chromosome"
abfdr <- merge(ab, fdr_select, by="Chromosome")
write.table(abfdr, "GO_spruce_fdr.tsv", sep="\t", col.names=TRUE, quote=FALSE)
