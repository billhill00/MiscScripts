#!/usr/bin/python
# Generate simple plot from stdin or files named on command line
# bill.hill@igmm.ed.ac.uk 20161019

from __future__ import print_function

import os
import sys
import getopt
import string
import commands
import numpy as np
import matplotlib.pyplot as plt

def showUsage(prog): #{
  print(prog + ': [-h] [-o <output file>] [<input file>]', file=sys.stderr)
#}

def main(): #{
  infiles = ['-']
  outfile = '-'
  try: #{
    opts, args = getopt.getopt(sys.argv[1:], "ho:", ['help','ofile='])
  except getopt.GetoptError: #}{
    showUsage(sys.argv[0])
    sys.exit(1)
  #}
  for opt, arg in opts: #{
    if opt == '-h': #{
      showUsage(sys.argv[0])
      sys.exit(0)
    elif opt in ("-o", "--ofile"): #}{
      outfile = arg
    #}
  #}
  if(len(args) > 0): #{
    infiles = args
  #}
  fig, axs = plt.subplots(nrows=1, ncols=1)
  for f in infiles: #{
    if f == '-': #{
      fp = sys.stdin
    else: #}{
      fp = open(f)
    #}
    data = np.array([[float(v) for v in line.split()] for line in fp])
    if data.shape[1] < 2: #{
      x = range(0,data.shape[0])
      y = data[:, 0]
    else: #}{
      x = data[:, 0]
      y = data[:, 1]
    #}
    plt.plot(x, y, 'r.-')
  #}
  plt.show()
#}

if __name__ == "__main__":
  main()
