reset

set terminal svg enhanced size 1280,720 font 'PT Serif,24'
set termoption dash

set samples 400
set isosamples 400

x_min=515
x_max=4000
y_min=2.
y_max=105.
y=((y_max-y_min)**2)**(1/2)

set output 'tmp.svg'

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
set style line 3 lt 3 lc -1

set label 1 at 3000,80 'Pulver A' tc ls 1
set label 3 at 1800,20 'O-Acetyl.' tc ls 3
set label 2 at 2700,98 'ASS' tc ls 2

p "tmp27.dat" u 1:2 smooth csplines lw 2.5 lt 1 lc -1, \
  "tmp272.dat" u 1:(100-300*$2) smooth csplines lw 3.0 lt 5 lc -1, \
  "tmp273.dat" u 1:2 smooth csplines lw 3.0 lt 3 lc -1
