#!/bin/Rscript

# Load packages
library(dplyr)
library(ggplot2)
library(ggrepel)

# Define functions
# Calculate Z score
Zscore <- function(res) {
	pop_sd <- sd(res$pos.lfc)*sqrt((length(res$pos.lfc)-1)/length(res$pos.lfc))
	pop_mean <- mean(res$pos.lfc)
	pos_zScore <- (res$pos.lfc - pop_mean)/pop_sd
	res2 <- data.frame(res, Zscore=pos_zScore)
	return(res2)
}

# Plot duplications
plot_Zscore <- function(rep1, rep2, rank=200, fig="dup_plot.tif") {
	rep1 <- Zscore(rep1)
	rep2 <- Zscore(rep2)
	pos.common <- intersect(rep1[rep1$pos.rank <= rank,]$id, rep2[rep2$pos.rank <= rank,]$id)
	neg.common <- intersect(rep1[rep1$neg.rank <= rank,]$id, rep2[rep2$neg.rank <= rank,]$id)
	common.id <- union(pos.common, neg.common)
	if (length(common.id) == 0 ) {
		print("No duplicates between these two replicate samples!")
		return(1)
	}
	rep1.common <- rep1[rep1$id %in% common.id, ]
	rep2.common <- rep2[rep2$id %in% common.id, ]
	
	index <- match(rep1.common$id, rep2.common$id)
	#print("test match")
	common.data <- data.frame(id=rep1.common$id, rep1.Zscore=rep1.common$Zscore, rep2.Zscore=rep2.common[index,]$Zscore)
	#print(common.data)
	common.data <- mutate(common.data, clas=ifelse(rep1.Zscore < 0, "Positive regulators", "Negative regulators"))
	#print("test mutate")
	tiff(filename=fig, width=5.5, height=4, units="in",compression="lzw",res=300)
	#plot
	
	p <- ggplot(common.data, aes(rep1.Zscore, rep2.Zscore)) +
		 geom_point(aes(col=clas)) +
		 scale_x_continuous(limits = c(-12.5, 12.5)) +
		 scale_y_continuous(limits = c(-12.5, 12.5)) +
		 geom_hline(yintercept=0,color="grey60") +
		 geom_vline(xintercept=0,color="grey60") +
		 geom_abline(intercept=0, slope=1,color="grey60") +
		 scale_color_manual(values=c("blue","red")) +
		 labs(title="Reproducible Hits in Two Screens", x="Screen using CD69 as marker", y="Screen using CFSE as marker") +
	 	 theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), panel.background=element_blank(),
	 	 	   panel.border=element_rect(fill=NA), plot.title=element_text(hjust=0.5))

	#print("test")
	p + geom_text_repel(data=common.data, aes(label=id))
}


