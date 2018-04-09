#!/usr/bin/env python
#----------------USAGE-----------------------
#This script parses a .sam alignment file and returns a tab-delimited text file with the 
#number of good quality (above a certain mapping quality threshold and read length) singly aligned 
#reads for every sgRNA in the reference sequence database. 
#The input text for the command line is:
#countxpression.py mapqualitythreshold (255), lengththreshold (20), outputstatsfilename, anynumberofinputfiles ...  

import operator

def countxpression(infilename, threshold, lengththresh, statsfile, countsfile, flag):
	print " Count reads for ", infilename
	#Opens an infile specified by the user. Should be a .sam file 
	IN = open(infilename, 'r')
	
	threshold=float(threshold) #inputs a mapping quality threshold for counting reads as sucessfully mapped
	lenthresh=float(lengththresh)
	
	#Opens an output text file as specified by user 
	OUT = open(countsfile, 'w')
	fstats = open(statsfile, 'a')
	
	totreads=0
	notaligned=0
	aligned=0
	perfect_aligned=0
	
	#Starts a for loop to read through the infile line by line
	sgRNAs={}
	for line in IN:
	
		line=line.rstrip()
		cols=line.split('\t')
		
		if cols[0]=="@SQ": #Generate dictionary of contig names
			sgRNA_ID=cols[1].split(':')[1]
			sgRNAs[sgRNA_ID]=0
		if cols[0][0] != '@' : #to skip past header
			totreads+=1
			if float(cols[1]) == 4 or float(cols[1]) == 20: #this is to count reads that are flagged as unaligned
				notaligned+=1
	
			elif float(cols[-2].split(':')[2]) >= 19: # for reads aligned with less than 1 mismatch
				if float(cols[4]) >= threshold and len(cols[9]) >= lenthresh:
					perfect_aligned+=1
					sgRNAs[cols[2]]+=1
	IN.close()
	
	aligned = totreads - notaligned
	notperfect_aligned = aligned - perfect_aligned
	
	propqualaligned=float(perfect_aligned)/float(totreads)

	if flag: # Only output the header once when handling the first file.
		fstats.write('%s\t%s\t%s\t%s\t%s\t%s\t%s\n' % ('Filename', 'Total#Reads', 'NumUnaligned', 'NumAligned', 'Not_perfect_matched', 'Perfect_mathed', 'Perfect_Aligned(%)'))

	fstats.write('%s\t%d\t%d\t%d\t%d\t%d\t%.3f\n' % (infilename, totreads, notaligned, aligned, notperfect_aligned, perfect_aligned, propqualaligned))
	fstats.close()

	OUT.write('sgRNA_ID'+'\t'+'Count')
	
	sorted_sgRNAs = sorted(sgRNAs.items(), key=operator.itemgetter(1))
	sorted_sgRNAs.reverse()

	for each in sorted_sgRNAs:
	#	print item
		OUT.write('\n%s\t%d' % (each[0], each[1]))
	
	OUT.close()



if __name__=="__main__":
	import sys
	filelist=sys.argv[4:]
	filenum = 0
	for file in filelist:
		filenum += 1
		if filenum == 1:
			countxpression(file, sys.argv[1], sys.argv[2], sys.argv[3], file[:-4]+'_counts.txt', 1)
		if filenum > 1:
			countxpression(file, sys.argv[1], sys.argv[2], sys.argv[3], file[:-4]+'_counts.txt', 0)




