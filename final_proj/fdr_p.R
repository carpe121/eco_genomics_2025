library(tidyverse)
library(qvalue) # cite Storey 2011

outs <- read.delim("hotcon_asso_2.lrt0", header=T)
pval <- 1-pchisq(outs$LRT, df=1)
# df=degrees of freedom; ANGSD does 1 DF for LRT

outs$pv <- pval
head(outs)

# pi0 = 0.779769

qobj <- qvalue(outs$pv, fdr.level=0.05)
outs$qval <- qobj$qvalues
filtouts <- outs %>% filter(qval < 0.05)

write_tsv(filtouts, "hotcon_fdr.tsv", na="NA", col_names=TRUE)