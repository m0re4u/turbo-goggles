set term png
set output 'results/el_pretrain_PickupLoc.png'

set key top right
set datafile separator comma

set title "Episode length during training on PickupLoc (pretrained on GoToLocal)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean episode length"

plot 'data/agg_2266709_episode_length.csv' using 2:3 smooth bezier lw 2 title "Segment", \
     'data/agg_2265467_episode_length.csv' using 2:3 smooth bezier lw 2 title "Word", \
     'data/agg_2266708_episode_length.csv' using 2:3 smooth bezier lw 2 title "WA"