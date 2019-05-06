set term png
if (!exists("filename")) filename='data/ep_length.csv'
if (!exists("outfile")) outfile='test.png'
set output outfile

set key autotitle columnhead
set datafile separator comma


set title "Episode length during training for file:".filename noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean episode length"
set yrange [0:1.1]



plot filename using 2:3 with lp lw 0.1 lc rgb "#AA0000AA" title "", \
           '' using 2:3 smooth bezier lw 3 title ""
