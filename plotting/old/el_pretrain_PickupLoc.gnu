set term png
set output 'results/el_pretrain_PickupLoc.png'

set key top right
set datafile separator comma

set title "Episode length during training on PickupLoc (pretrained on GoToLocal)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean episode length"

plot 'data/el_pre_PickupLoc_segment_averaged.csv' using 2:3 smooth bezier lw 2 title "Segment", \
     'data/el_pre_PickupLoc_word_averaged.csv' using 2:3 smooth bezier lw 2 title "Word", \
     'data/el_pre_PickupLoc_wordannotated_averaged.csv' using 2:3 smooth bezier lw 2 title "WA"