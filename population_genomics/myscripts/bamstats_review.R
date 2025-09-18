setwd("population_genomics/myresults")

stats <- read.table("2019.stats.txt", header=T, sep="\t")
stats$prctPaired <- stats$Num_Paired/stats$Num_reads