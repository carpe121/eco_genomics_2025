library(tidyverse)

setwd("/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/")

## READ IN FILES ##

# Read in GO Annotation file for Black Spruce Genome
go_anno <- read.table("/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ref_genome/Pmariana/annotation/GO_annotations/Pmariana_GO_annotations_sorted_join.txt", header=F, fill=T)
ga_new <- go_anno %>% 
  mutate(V7=ifelse(V7 %in% "", V2,V7)) #fill missing contig names
colnames(ga_new) <- c("gene", "start", "stop", "geneID", "strand", "parent", "contig")

# Read in bed file of FDR-corrected intersecting genes
rs_bed <- read.table("/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/RS_bt2", header=F)
colnames(rs_bed) <- c("contig", "start", "stop", "geneID")
rb2 <- rs_bed %>% select(contig)

## MERGE FILES 
rbinner <- merge(rb2, ga_new, by="contig")##
rbonto <- rbinner %>% 
  select(gene, start)
rbonto$gene <- gsub("Ontology_term=", '', rbonto$gene)
rbonto$gene <- gsub(",", ", ", rbonto$gene)
colnames(rbonto) <- c("gene", "contig")

#output is list of all known sites associated with GO terms with q < 0.05

#write.table(rbonto, "GO_table_spruce.tsv", sep="\t", col.names=TRUE, quote=FALSE)

fdr <- read.table("/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/hotcon_fdr.tsv", header=T)
fdr_subs <- fdr %>% 
  select(Chromosome, qval) %>%
  arrange(qval) |>
  head(n=1000) #get top 1000 most significant genes

colnames(fdr_subs) <- c("contig", "qval")

fdr_sig <- merge(fdr_subs, rbonto, by="contig")
fdr_sig2 <- fdr_sig %>% 
  filter(grepl("GO:", gene)) %>%
  select(gene)

write.table(fdr_sig2, "GO_spruce_fdr.tsv", sep="\t", col.names=FALSE, quote=FALSE)

# output is data table of 1000 MOST SIGNIFICANT SITES associated with GO terms

# switch to unix
# COMMAND TO OUTPUT LIST FOR REViGO
# sed 's/'GO'/\n'GO'/g' GO_spruce_fdr.tsv | sed 's/','/''/g' test.txt > test2.txt | awk '/GO/ {print}' | uniq > final.txt
# wc -l = 4810127

## COMPARE TO TRANSCRIPTION DATA ##
# Fit rbonto data for processing #

rbon2 <- rbonto %>% select(gene)
write.table(rbon2, "all_GO_spruce.tsv", sep="\t", col.names=TRUE, quote=FALSE)

## UNIX
# sed 's/'GO'/\n'GO'/g' all_GO_spruce.tsv | sed 's/','/''/g' | awk '/GO/ {print}' | uniq > all_GOfinal.txt

temp = list.files(pattern="\\.txt$")
myfiles = lapply(temp, read.table)

names(myfiles) <- c("cwCvsDH", "cwCvH", "cwHvsDH", "hdCvsDH", "hdCvsH", "hdHvsDH")

outs <- list()

for(i in 1:as.numeric(length(temp))){
  rep <- myfiles[[i]]
  colnames(rep) <- rep[1,]
  rep_2 <- rep %>% slice(-1)
  inj <- inner_join(rep_2, all_GOs, join_by(GO.ID==V1))
  outs[[i]] <- unique(inj$GO.ID)
}

for(i in 1:as.numeric(length(temp))){
  y <- as_tibble(assign((names(myfiles))[i], outs[[i]]))
  write.table(y, paste0((names(myfiles)[i]), ".tsv"), sep="\t", quote=FALSE, col.names=FALSE, row.names=FALSE)
}