#!/bin/Rscript
# draw a distribution plot of sgRNA log2 fold change and add topgenes
# xxx Usase: Rscript sgRNA_density.R sgRNA_summary_file distrib.tiff 
sgRNA.density.plot <- function(infile=sgRNA_summary_file,
							   outfile="distribution.tiff",
							   genes=pickouts,gene_col=colors) {
	# "infile" is the sgRNA_summary_file OUTPUT from Mageck 0.5.7.
	# "outfile" is the file for output a "tiff" format file.
	# "genes" is a list of genes for displaying under the distribution plot.
	# "gene_col" is a list of colors corresponding to "genes".
	gene_num <- length(genes)
	if(gene_num > 8) {
		print("Too many genes to illustrate in one figure\n")
		return(1)
	}
	else if(gene_num <= 0) {
		print("No. of genes is 0.\n")
		return(1)
	}
	# Load data from mageck output file: sgRNA_summary
	sgrna_sum <- read.table(infile,sep='\t',header=T)
	# Plot the distribution figure
	z <- sgrna_sum$LFC
	d <- density(z)
	tiff(filename=outfile, width=4, height=0.5*(gene_num+3),
		 units="in",compression="lzw",res=300)
	par(mar=c(4,2.5,2,1))
	par(mfcol=c(gene_num+1,1))
	tmp_mar <- gene_num + 3
	par(fig=c(1.5,tmp_mar,gene_num,tmp_mar)/tmp_mar)
	plot(d,xlab="Log2FC(sgRNA)",ylab="",main="",cex.lab=1.5)
	polygon(d,col="gray60",border="black")
	# Plot genes separatly
	par(mar=c(0.5,2.5,1,1))
	n <- gene_num
	for(i in c(1:n)){		
		par(fig=c(1.5,tmp_mar,n-i,n-i+1)/tmp_mar)
		par(new=T)
		plot(c(min(z),max(z)), c(0,0.5),axes=F,xlab="",ylab="",type="n")
		abline(v=sgrna_sum$LFC, col="gray60")
		abline(v=sgrna_sum[sgrna_sum$Gene==genes[i],]$LFC, col=gene_col[i])
		box()
		mtext(genes[i],side=2,las=1,line=1)
	}
	dev.off()
	return(0)

}

sgRNA.density.plot("1x_primary.sgrna_summary.txt","1x_primary_dist.tiff", c("CBLB","CD5","UBASH3A","VAV1","CD3D","LCP2"), c("blue","blue","blue","red","red","red"))

sgRNA.density.plot("1x_primary.sgrna_summary.txt","1x_primary_dist.tiff", c("CBLB","CD5","UBASH3A","VAV1","CD3D"), c("blue","blue","blue","red","red"))

sgRNA.density.plot("1x_primary.sgrna_summary.txt","1x_primary_dist.tiff", c("CBLB","CD5","UBASH3A","VAV1"), c("blue","blue","blue","red"))

