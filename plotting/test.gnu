set key autotitle columnhead
set datafile separator comma

set title "Episode length during training"
set xlabel "Number of training iterations"
set ylabel "Mean episode length"

plot 'ep_length.csv' using 2:3 with lp lw 0.1, \
                  '' using 2:3 smooth bezier lw 3
