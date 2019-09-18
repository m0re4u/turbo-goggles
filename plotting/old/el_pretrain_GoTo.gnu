set term png
set output 'results/el_pretrain_GoTo.png'

set key top right
set datafile separator comma

set title "Episode length during training on GoTo (pretrained on GoToLocal)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean episode length"

plot 'data/agg_2266711_episode_length.csv' using 2:3 smooth bezier lw 2 title "Segment", \
     'data/agg_2265464_episode_length.csv' using 2:3 smooth bezier lw 2 title "Word", \
     'data/agg_2266710_episode_length.csv' using 2:3 smooth bezier lw 2 title "WA"