#!/usr/bin/Rscript
# Test optparse by passing a list of filenames to one argument by commandline 
#
args <- commandArgs(trailingOnly=TRUE)

cnt_dat <- list()
id_list <- c()
print("Combining all count files...")
for (i in c(1:length(args))){
	cnt_dat[[i]] <- read.table(args[i], sep='\t', header=TRUE)
	id_list <- union(cnt_dat[[i]][,1], id_list)
}
# Combine all count data into a matrix
id_list <- id_list[order(id_list)]
cnt_matrix <- data.frame(row.names=id_list)
print("Quantile normalize the data...")
for (i in c(1:length(args))){
	print(args[i])
	row_names <- cnt_dat[[i]][,1]
	no_ids <- id_list[!is.element(id_list, row_names)]
	tmp <- data.frame(no_ids, rep(0, length(no_ids)))
	one_dat <- rbind(cnt_dat[[i]], tmp)
	one_dat <- one_dat[order(one_dat[,1]), ]
	cnt_matrix <- data.frame(cnt_matrix, one_dat[,2])
	colnames(cnt_matrix)[length(colnames(cnt_matrix))] <- args[i]
}

# Quantile normalization
library(preprocessCore)
cnt_mat <- normalize.quantiles(as.matrix(cnt_matrix) + 1)
colnames(cnt_mat) <- colnames(cnt_matrix)
rownames(cnt_mat) <- rownames(cnt_matrix)
print("Finished.")
write.table(cnt_mat, file="counts_qu_norm.txt", sep='\t', quote=F)
