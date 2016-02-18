set terminal svg enhanced font 'Times New Roman'

set output 'inter.svg'

set grid
set key bottom left

set xlabel "Wellenzahl in cm^{-1}"
set ylabel "rel. Absorbtionink"

p [450:4000] "inter.dat"  with lines

