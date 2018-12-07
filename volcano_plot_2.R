#!/usr/bin/Rscript
#
# Usage: Rscript volcano_plot_2.R gene_summary.txt volcano_plot_2.pdf

# Load packages
library(dplyr)
library(ggplot2)
library(ggrepel)

args <- commandArgs(trailingOnly=TRUE)
DATA_FILE <- args[1]
PDF_FILE <- args[2]

# create a PDF file
pdf(file=PDF_FILE)

res <- read.table(DATA_FILE,sep='\t',header=T)
#head(res)

# Calculate Z score
pop_sd <- sd(res$pos.lfc)*sqrt((length(res$pos.lfc)-1)/length(res$pos.lfc))
pop_mean <- mean(res$pos.lfc)
pos_zScore <- (res$pos.lfc - pop_mean)/pop_sd
res2 <- data.frame(res, Zscore=pos_zScore)
# head(res2)
# Classify data into three classes
res2 <- mutate(res2, clas=ifelse((neg.fdr<0.2 & Zscore<(-2)),"Neg_top_hits", ifelse((pos.rank<21 & Zscore>2),"Pos_top_hits","Not concerned")))


# Plot 
p <- ggplot(res2, aes(Zscore, ifelse(Zscore > 0, -log10(pos.p.value), -log10(neg.p.value)))) +
	geom_point(aes(col=clas)) +
	scale_color_manual(values=c("red","black","blue")) +
	labs(title="GW Screen for T Cell Proliferation", x="Zscore", y="-log10(p-value)") +
	theme(plot.title=element_text(hjust=0.5))

# Label dots with gene name
p+geom_text_repel(data=filter(res2, (pos.rank < 21 | neg.fdr < 0.2) & abs(Zscore) > 2 ), aes(label=id))

# Load gene list of TCR signaling pathway from GO
TCR_sig <- read.table("/home/sucsb/Databases/Gene_Ontology/TCR_signaling_pathway", sep='\t', header=F)[[1]]
TCR_sig <- toupper(TCR_sig)

# Label genes belonging to TCR signaling pathway 
p+geom_text_repel(data=filter(res2, (pos.fdr < 0.2 | neg.fdr < 0.2) & abs(Zscore) > 2 & is.element(id, TCR_sig)), aes(label=id))

# Add title and axis labels


dev.off()
