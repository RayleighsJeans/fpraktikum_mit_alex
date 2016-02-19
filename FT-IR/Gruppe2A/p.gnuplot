set terminal svg enhanced font 'PT Serif,24'

set output 'inter.svg'

stats 'tmp.dat' u 1:2 nooutput

set yrange [STATS_min_y+STATS_min_y/10:STATS_max_y+STATS_max_y/10]

set grid
unset key

set border linewidth 1.8
set tics nomirror out scale 0.8

set xlabel "rel. Spiegelposition"
set ylabel "Interferenz-Intensität, a.u."

p [-500:500] "tmp.dat" with lines lw 1.8

