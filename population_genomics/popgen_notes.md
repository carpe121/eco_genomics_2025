# Population Genomics Notebook

## Fall 2025 Ecological Genomics

## Author: Madeline Carpenter

Notes for population genomics coding sessions.

### 09/11/25: Cleaning fastq reads of red spruce

Wrote a bash script called `fastp.sh` located within my GitHub repo:

`~/projects/eco_genomics_2025/population_genomics/myscripts`

Used this to trim adapters from red spruce fastq sequence files.

Assigned population **2019**.

The raw fastq files were located in the class share space:

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/fastq/red_spruce`

Using the program `fastp`, we processed the raw reads and output the cleaned reads to the following directory on the class shared space:

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/cleanreads`

`fastp` produced reports for each sample, which I saved into the directory in html format:

`~/projects/eco_genomics_2025/population_genomics/myresults/fastp_reports`

The results showed high-quality sequence, with most Q-scores being >>20 and low amounts of adapter contamination, which we trimmed out. We also trimmed out the leading 12 bp to get rid of barcoded indices. Cleaned reads are now ready to process to next step: mapping to reference genome.


### 09/16/25: Mapping cleaned reads to reference genome

Copied additional script files from class script repo at 

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/scripts`

into the `myscripts/` folder for use with red spruce genomics.

Red spruce aligned to reference genome using `mapping.sh` and `SBATCH_header.txt` with the program BWA-mem. BWA-mem did not work for all samples and will need to resubmit later.

`myscripts/process_bam.sh` and `myscripts/bam_stats.sh` were combined into a wrapper.


### 09/18/25: Review bamstats and set up nucleotide diversity estimation using ANGSD

Reran script because I forgot to add "G" to `process_stats_wrapper.sh` Slurm memory requirements.

Wrote a short script called `bamstats_review.R` located in `myscripts/` to evaluate mapping success.

Saw about 66% of genome mapped to proper views.

Copied script `ANGSD.sh` to `myscripts/` to quickly generate all the filenames needed for ANGSD to analyze, then run ANGSD. The first run was to analyze all sites on the genome.

Make sure `--nThreads` equals `SBATCH --cpus-per-task`.

Made a second script called `ANGSD_.sh` to estimate theta and other metrics of genomic diversity along the genome. `ANGSD.sh` and `ANGSH_.sh` were placed in a wrapper `diversity_wrapper.sh` together to run over the weekend.

### 09/23/25
Checked on ANGSD results from the weekend. Built new Rmd script, `Nucleotide_Diversity.Rmd`, in the `mydocs` folder. In the Rmd, we explored the ANGSD results by calculating pi and Watterson's theta, and using `ggplot2` to graph the results.

We also calculated effective population size for each of our samples using Watterson's theta. The results are stored in a lab-wide Google Sheets. We concluded by calculating the maximum and minimum Tajima's D across the genome.

Results suggest latitudinal trend in diversity (highest in the north, lowest in the south).

### 09/25/25
Wrote script `ANGSD_Fst.sh` to calculate Fst between black and red spruce populations. Ran script during class time. We used the `beagle` file in the class datashare with the genotype likelihoods already computed: `/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ANGSD/RSBS_poly.beagle.gz`. Population for my population (2019) has an Fst value of 0.371953 compared to black spruce.

Wrote script `PCAngsd_RSBS.sh` to display PCA for all populations of red (n=95) and black spruce (n=18) populations. Ran script during class time.

Graphed PCA and ADMIXTURE plots in Rmd `PCA_Admix.Rmd` and saved in `mydocs/`.

### 09/30/25
Reran PCA and ADMIXTURE plots with K=3 to see how K changes PCA values.

Wrote a script called `PCAngsd_allRS_selection.sh` to calculate minor allele frequency.







