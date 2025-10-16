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

"What is happening in the first generation moved 22 -> 18C? What transcription is changing?"

To answer this question, we examined several different genes with highly differentiated expression across treatment groups.



