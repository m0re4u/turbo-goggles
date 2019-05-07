set term png
set output 'results/el_pretrain_PutNextLocal.png'

set key top right
set datafile separator comma

set title "Episode length during training on PutNextLocal (pretrained on GoToLocal)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean episode length"

plot 'data/agg_2266462_episode_length.csv' using 2:3 smooth bezier lw 2 title "Segment", \
     'data/agg_2265470_episode_length.csv' using 2:3 smooth bezier lw 2 title "Word", \
     'data/agg_2266463_episode_length.csv' using 2:3 smooth bezier lw 2 title "WA"