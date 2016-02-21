reset

set terminal svg enhanced font 'PT Serif,24'
set termoption dash

set samples 400
set isosamples 400

x_min=1.1
x_max=4.0
y_min=0.0
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

#set key outside
#set key center top
#set key horizontal

set border linewidth 3.0
set tics nomirror out scale 0.7

set xlabel "Wellenzahl / 10^{3}cm^{-1}"
set ylabel "rel. Transmission, a.u."

set style line 2 lt 1 lc -1
set style line 1 lt 5 lc -1
set style line 3 lt 3 lc -1

set label 1 at 1.8,40 'Oliv.' tc ls 1
set label 2 at 3,10 'C_{18}H_{36}O_{2}' tc ls 2

p "tmp7.dat" u ($1/1000):2 smooth csplines lw 2.5 lt 2 lc -1, \
  "tmp50.dat" u ($1/1000):($2-11) smooth csplines lw 3.0 lt 1 lc -1
