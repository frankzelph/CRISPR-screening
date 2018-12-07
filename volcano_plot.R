
# create a PDF file
pdf(file="Volcano_plot.pdf")

res <- read.table("1x_primary.gene_summary.txt",sep=',',header=T)
head(res)

# Calculate Z score
pop_sd <- sd(res$pos.lfc)*sqrt((length(res$pos.lfc)-1)/length(res$pos.lfc))
pop_mean <- mean(res$pos.lfc)
pos_zScore <- (res$pos.lfc - pop_mean)/pop_sd
res2 <- data.frame(res, Zscore=pos_zScore)
head(res2)

# Volcano Plot
with(res2, plot(Zscore, ifelse(Zscore > 0, -log10(pos.p.value), -log10(neg.p.value)), pch=20, main="GW Screen for T Cell Proliferation",xlim=c(-12,12),ylim=c(0,7), xlab= "Z-score", ylab="-log10(p-value)"))
# Set negative top hits (FDR<0.2 AND Z-score < -2) to be red.
with(subset(res2, (neg.fdr < 0.2 & Zscore < -2)), points(Zscore,-log10(neg.p.value),pch=20, col="red"))
# Set positive top hits (rank<20 AND Z-score > 2) to be blue.
with(subset(res2, (pos.rank < 20 & Zscore > 2)), points(Zscore,-log10(pos.p.value),pch=20, col="blue"))

# Load gene list of TCR signaling pathway from GO
TCR_sig <- read.table("/home/sucsb/Databases/Gene_Ontology/TCR_signaling_pathway", sep='\t', header=F)[[1]]
TCR_sig <- toupper(TCR_sig)

# Label points with textxy function from the calibrate plot
# Shortage: labels would be overlapped!
library(calibrate)
with(subset(res2, (pos.fdr < 0.2 | neg.fdr < 0.2) & abs(Zscore) > 2 & is.element(id, TCR_sig)), textxy(Zscore, ifelse(Zscore > 0, -log10(pos.p.value), -log10(neg.p.value)), labs=id, cex=.5, col="green"))

dev.off()
