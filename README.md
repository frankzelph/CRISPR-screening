# CRISPR-screening
Procedures for pooled sgRNA screening analysis.
1. QC: fastqc
2. Trim: cutadapt
3. Reads mapping: bowtie
4. Counts: count_sgRNAFsam.py
5. Quantile normalization: quan_norm.r
6. Basic quality check: whether sgRNAs targeting essential genes are depleted in transduced cells from input plasmid library?
                        Whether sgRNAs targeting known hits are enriched?
7. Comparison methods:
    a. Z-score
    b. Gene differential expression
    c. RIGER
    d. STAR
    e. MaGeck
 
 sgRNA_density.R: for ploting the density of sgRNA log2 fold change and displaying the sgRNA LCF of topgenes
 volcano_plot.R: for volcano plot of all genes, and label some top genes.
