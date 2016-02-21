reset

set terminal svg enhanced size 1280,720 font 'PT Serif,24'
set termoption dash

set samples 800
set isosamples 800

x_min=605.0
x_max=3500.0
y_min=5.0
y_max=112.
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

set xlabel "Wellenzahl / cm^{-1}"
set ylabel "rel. Transmission, a.u."

set style line 1 lt 1 lc -1
set style line 2 lt 5 lc -1
set style line 3 lt 1 lc -1

set label 1 at 2200,103 'PVC' tc ls 1
set label 2 at 2850,23 'Folie' tc ls 2
set label 3 at 1800,25 'Dibutylphtalat' tc ls 3

p "tmp8.dat" smooth csplines lw 2.5 lt 1 lc -1, \
  "tmp15.dat" smooth csplines lw 3.0 lt 5 lc -1, \
  "tmp14.dat" u 1:($2-10) smooth csplines lw 3.0 lt 3 lc -1
