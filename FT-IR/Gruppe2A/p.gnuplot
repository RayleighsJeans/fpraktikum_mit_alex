set terminal svg enhanced font 'PT Serif,18'

set output 'meth_diff.svg'

set grid
set key bottom left

set xlabel "Wellenzahl in cm^{-1}"
set ylabel "rel. Absorbtion"

p [450:4000] [0:1.1] "meth_diff.dat" u 1:($2)/100 with lines

