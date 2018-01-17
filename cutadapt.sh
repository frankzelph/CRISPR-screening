#!/bin/bash

# 1AD-NGS
cutadapt -j 24 -g -m 20 TCTTGTGGAAAGGACGAAACACCG...gttttagagctagaaatagcaagtta --discard-untrimmed -o trimed_seq/1AD-NGS_trimed_R1.fasta 1AD-NGS_combined_R1.fastq.gz
# 2AD-NGS
cutadapt -j 24 -g -m 20 TCTTGTGGAAAGGACGAAACACCG...gttttagagctagaaatagcaagtta --discard-untrimmed -o trimed_seq/2AD-NGS_trimed_R1.fasta 2AD-NGS_combined_R1.fastq.gz
# 1A
cutadapt -j 24 -g -m 20 TCTTGTGGAAAGGACGAAACACCG...gttttagagctagaaatagcaagtta --discard-untrimmed -o trimed_seq/1A-NGS_trimed_R1.fasta 1A-NGS_combined_R1.fastq.gz
# 2A
cutadapt -j 24 -g -m 20 TCTTGTGGAAAGGACGAAACACCG...gttttagagctagaaatagcaagtta --discard-untrimmed -o trimed_seq/2A-NGS_trimed_R1.fasta 2A-NGS_combined_R1.fastq.gz
# 1B-1
cutadapt -j 24 -g -m 20 TCTTGTGGAAAGGACGAAACACCG...gttttagagctagaaatagcaagtta --discard-untrimmed -o trimed_seq/1B-1_trimed_R1.fasta 1B-1_combined_R1.fastq.gz
#2B-1
cutadapt -j 24 -g -m 20 TCTTGTGGAAAGGACGAAACACCG...gttttagagctagaaatagcaagtta --discard-untrimmed -o trimed_seq/2B-1_trimed_R1.fasta 2B-1_combined_R1.fastq.gz



# cutadapt -j 24 -g -m 20 TCTTGTGGAAAGGACGAAACACCG...gttttagagctagaaatagcaagtta --discard-untrimmed -o trimed_seq/1AD-NGS_trimed_R1.fastq -p trimed_seq/1AD-NGS_trimed_R2.fastq 1AD-NGS_combined_R1.fastq.gz 1AD-NGS_combined_R2.fastq.gz
