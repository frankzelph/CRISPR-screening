#!/bin/bash
# Map the sgRNA reads to library reference using Bowtie
#
# Database directory
db_dir=/home/sucsb/database/mouse_geckov2/bowtie_index

for item in `ls `
do
	if [ -f $item ] && [[ $item == *"fastq" ]]; then
		bowtie ${db_dir}/libAB -q $item -m 1 -v 0 -norc -p 32 -S ${item%%.*}.sam
	fi
done
