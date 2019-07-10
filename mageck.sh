#!/bin/bash

# Brunello library
Brunello_Lib=/home/sucsb/Databases/CRISPR/Brunello/brunello-library.csv

# Pilot library
Pilot_Lib=pilot-library.csv

# Adg_lib #67989
Adg_Lib=/home/sucsb/Databases/CRISPR/Adg_lib/Adg_lib.csv


# Screening PD-1 signaling pathway using CFSE to indicate dividing and non-dividing cells
# Stimulant: CD3/CD28/PD-L1 beads
mageck count -l $Adg_Lib -n PD1_sig --sample-label Div,NonDiv  --fastq 18.fastq.gz,22.fastq.gz 17.fastq.gz,21.fastq.gz --pdf-report

mageck test -k PD1_sig.count_filtered.txt -t Div -c NonDiv -n PD1_sig --pdf-report

