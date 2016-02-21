reset

set terminal svg enhanced size 1280,720 font 'PT Serif,24'
set termoption dash

set samples 500
set isosamples 500

x_min=1100.0
x_max=4000.0
y_min=-5
y_max=110.0
y=((y_max-y_min)**2)**(1/2)

set output 'tmp.svg'

stats 'tmp.dat' u 1:2 nooutput

#set yrange [STATS_min_y+STATS_min_y/10:STATS_max_y+STATS_max_y/10]
#set xrange [STATS_min_x:STATS_max_x]

set xrange [x_min:x_max]
set yrange [y_min:y_max]

set grid

#set key outside
#set key center
#set key nobox
#set key bmargin 
#set key at 3100,118.5
unset key

set border linewidth 3.0
set tics nomirror out scale 0.7

set xlabel "Wellenzahl / cm^{-1}"
set ylabel "rel. Transmission, a.u."

set style line 2 lt 1 lc -1
set style line 1 lt 5 lc -1
set style line 3 lt 3 lc -1
set style line 4 lt 1 lc 1

set label 1 at 3040,5 'Erdnussöl, roh' tc ls 1
set label 2 at 2100,89 'Erdnussöl, korr.' tc ls 2
set label 3 at 2850,105 'Basislinie' tc ls 3
set label 4 at 1150,105 'Methyl-Linoleat' tc ls 4

p "tmp.dat" smooth csplines notitle lw 2.5 lt 3 lc -1, \
  "tmp2.dat" smooth csplines notitle  lw 2.5 lt 1 lc -1, \
  "tmp4.dat" w lines notitle lw 2.5 lt 5 lc -1, \
  "tmp10.dat" u 1:($2-24) smooth csplines title "Methyl-Linoleat" lw 2.5 lt 1 lc 1
#  "tmp11.dat" u 1:($2-24) smooth csplines title "Metyhl-Palmitat" lw 2.5 lt 1 lc 2
