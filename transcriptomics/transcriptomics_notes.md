# Transcriptomics Notes

This `.md` file will keep my notes on server activities during the transcriptomics module.

## October 7

Began transcriptomics unit. Began with cleaning RNA sequencing reads from new study species, *P. tonsa*, using Fastp within the script `fastp_tonsa.sh`. My sample is **C1R**.

## October 9

Returned to `fastp_tonsa.sh` and completed cleaning reads. Cleaned reads were passed to the shell script `salmon_quant.sh`.

## October 14

Finished work on Salmon. Extracted numeric mapping rate from each log file and stored it in `transcriptomics/myresults/mapping_rate_list.txt`. Created the file `create_counts_matrix.R` in `transcriptomics/myscripts` to assemble all individually mapped reads into one data matrix.

Began work on DESeq2. Created Rmd `DESeq2_tonsa_multigen.Rmd` to process DESeq2 data. Examined different bins of data using histograms. Counted number of sequenced reads. Patched DESeq2 Rmd to match column names to conds.

## October 16

Continued work on DESeq2 Rmd file. Plotted PCA, sample tree, and several heatmaps to characterize data. Ran another iteration of DESeq to examine pairwise contrasts between eight different experimental groups.

"What is happening in the first generation moved 22 -\> 18C? What transcription is changing?"

To answer this question, we examined several different genes with highly differentiated expression across treatment groups.

## October 21

Continued work on DESeq2 Rmd file. Constructed heatmaps, volcano plots, and Euler plots (using `library(eulerr)`). Euler plots required counting the number of unique genes and identifying intersection of various generations, then subtracting genes overlapping between the first three generations. G4 could not be used because overlaps in differential-expressed genes between just two genes would be difficult to portray.

## October 23

Started new R Markdown file called `enrich.Rmd` to look at G.O. terms within *P. tonsa* dataset. G.O. analysis adjusted for p-values using non-parametric terms, then identified terms that were significantly enriched. Data was plotted into *GO Enrichment for DEGs* (just looked at Gen2).

## October 28

Last module of the transcriptomics unit. Started with WGCNA in a new Rmd file, `DESeq2toWGCNA.Rmd`. DESeq2 data was imported, alongside the counts matrix and the trait data. A set of soft-thresholding power was chosen. Although 22 was the most ideal fit for the data, I chose 16 because we all chose different powers as a class to see how the power affected data sorting. A power of 16 led to 18 modules, and the more ideal number of 22 also chose 18 modules. Plotted results into ReviGo to identify areas of GO enrichment.
