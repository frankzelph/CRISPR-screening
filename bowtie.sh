#!/bin/bash

# 1A
bowtie ~/database/GeCKOv2/bowtie_index/libA -f 1A-NGS_trimed_R1.fasta -m 1 -v 1 -norc -p 24 -S 1A.sam
# 2A
bowtie ~/database/GeCKOv2/bowtie_index/libA -f 2A-NGS_trimed_R1.fasta -m 1 -v 1 -norc -p 24 -S 2A.sam
# 1AD
bowtie ~/database/GeCKOv2/bowtie_index/libA -f 1AD-NGS_trimed_R1.fasta -m 1 -v 1 -norc -p 24 -S 1AD.sam
# 2AD
bowtie ~/database/GeCKOv2/bowtie_index/libA -f 2AD-NGS_trimed_R1.fasta -m 1 -v 1 -norc -p 24 -S 2AD.sam
# 1B-1
bowtie ~/database/GeCKOv2/bowtie_index/libB -f 1B-1_trimed_R1.fasta -m 1 -v 1 -norc -p 24 -S 1B-1.sam
# 2B-1
bowtie ~/database/GeCKOv2/bowtie_index/libB -f 2B-1_trimed_R1.fasta -m 1 -v 1 -norc -p 24 -S 2B-1.sam
