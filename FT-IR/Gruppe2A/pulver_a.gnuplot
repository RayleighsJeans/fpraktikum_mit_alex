reset

set terminal svg enhanced font 'PT Serif,24'
set termoption dash

set samples 400
set isosamples 400

x_min=0.515
x_max=4.0
y_min=30.0
y_max=110.
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

set label 1 at 1.25,40 'Pulver A' tc ls 1
set label 2 at 2.85,104 'Süßstoff' tc ls 2

p "tmp25.dat" u ($1/1000):2 smooth csplines lw 2.5 lt 1 lc -1, \
  "tmp252.dat" u ($1/1000):2 smooth csplines lw 3.0 lt 5 lc -1
