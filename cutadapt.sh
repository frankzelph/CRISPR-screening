#!/bin/bash
# Use cutadapt to trim both 5' and 3' ends of sgRNA spacer sequences.

if [ ! -d "trimed_seqs" ]; then
	echo "Make a directory named \"trimed_seqs\"."
	mkdir "trimed_seqs"
fi

for item in `ls `
do
	if [ -f "$item" ] && [[ $item == *"fastq" ]]; then
		cutadapt -j 32 -m 20 -g tatatatcttgtggaaaggacgaaacaccg...gttttagagctagaaatagc --discard-untrimmed -o trimed_seqs/${item%%.*}_trimed.fastq $item
	fi
done
