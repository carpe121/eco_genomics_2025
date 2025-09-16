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
