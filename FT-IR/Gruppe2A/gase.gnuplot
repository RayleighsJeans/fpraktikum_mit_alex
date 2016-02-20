reset

set terminal svg enhanced size 1280,720 font 'PT Serif,24'
set termoption dash

set samples 500
set isosamples 500

x_min=450.0
x_max=4000.0
y_min=-2
y_max=105.0
y=((y_max-y_min)**2)**(1/2)

set output 'tmp.svg'

stats 'tmp.dat' u 1:2 nooutput

#set yrange [STATS_min_y+STATS_min_y/10:STATS_max_y+STATS_max_y/10]
#set xrange [STATS_min_x:STATS_max_x]

set xrange [x_min:x_max]
set yrange [y_min:y_max]

set grid
unset key

set border linewidth 3.0
set tics nomirror out scale 0.7

set xlabel "Wellenzahl / cm^{-1}"
set ylabel "rel. Absorption, a.u."

set style line 1 lt 1 lc -1
set style line 2 lt 3 lc -1

set label 1 at 3150,25 'Methan, korr.' tc ls 1
set label 2 at 1800,75 'Basislinie' tc ls 2

p "tmp.dat" smooth csplines lw 2.5 lc -1, \
  "tmp2.dat" smooth csplines lw 2.5 lt 5 lc -1

