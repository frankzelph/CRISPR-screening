#!/bin/py

import re
from Bio import SeqIO
import sys

def main(seqfile, seqname):
	for seq in SeqIO.parse(seqfile, 'fasta'):
		if seq.id == seqname:
			print seq.seq

#===========================================
main(sys.argv[1], sys.argv[2])
