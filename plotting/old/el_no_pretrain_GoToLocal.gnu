set term png
set output 'results/el_no_pretrain_GoToLocal.png'

set key top right
set datafile separator comma

set title "Episode length during training on GoToLocal (no pretraining)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean episode length"

plot 'data/agg_2238716_episode_length.csv' using 2:3 smooth bezier lw 2 title "Segment", \
 'data/agg_2239329_episode_length.csv' using 2:3 smooth bezier lw 2 title "Word", \
 'data/agg_2239330_episode_length.csv' using 2:3 smooth bezier lw 2 title "WA"