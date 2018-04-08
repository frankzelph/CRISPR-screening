#!/bin/py

import re
import sys

def main(infile, outfile):
	fin = open(infile, 'r')
	fout = open(outfile, 'w')
	headline = fin.readline()
	#print headline
	outlines = ""
	for line in fin:
#		print line
		tmp = re.split('\,', line.rstrip())
		#print tmp
		outlines += '>' + tmp[0] + '_'+tmp[1]+ '\n' + tmp[2] + '\n'
		#print outlines
	fout.write(outlines)
	fin.close()
	fout.close()

#==============================================#
infile = sys.argv[1]
outfile = sys.argv[2]
print infile
main(infile, outfile)
		


