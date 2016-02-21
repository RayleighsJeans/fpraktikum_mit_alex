reset

set terminal svg enhanced  font 'PT Serif,24'
set termoption dash

set samples 10000
set isosamples 10000

#set samples 500
#set isosamples 500

x_min=0.45
x_max=3.5
y_min=80
y_max=94.0
y=((y_max-y_min)**2)**(1/2)

set output 'tmp.svg'

#stats 'tmp.dat' u 1:2 nooutput

#set yrange [STATS_min_y+STATS_min_y/10:STATS_max_y+STATS_max_y/10]
#set xrange [STATS_min_x:STATS_max_x]

set xrange [x_min:x_max]
set yrange [y_min:y_max]

set grid
unset key

set border linewidth 3.0
set tics nomirror out scale 0.7

set xlabel "Wellenzahl / 10^{3}cm^{-1}"
set ylabel "rel. Transmission, a.u."

set style line 2 lt 1 lc -1
set style line 1 lt 5 lc -1
set style line 3 lt 3 lc -1

set label 1 at 2200,81.5 'Aluminium' tc ls 1
set label 2 at 2500,92 'Teflon' tc ls 2
#set label 3 at 3000,105 'Basislinie' tc ls 3

p "tmp98.dat" u ($1/1000):2 w lines lw 2.5 lt 2 lc -1, \
  "tmp97.dat" u ($1/1000):2 w lines lw 2.5 lt 1 lc -1
# "tmp4.dat" w lines lw 2.5 lt 3 lc -1

