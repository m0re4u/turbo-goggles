set term png
set output 'results/sr_pretrain_PickupLoc.png'

set key bottom right
set datafile separator comma

set title "Succes rate during training on PickupLoc (pretrained on GoToLocal)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean succes rate"
set yrange [0:1.1]

plot 1 title "100% succes", \
 'data/sr_pre_PickupLoc_segment_averaged.csv' using 2:3 smooth bezier linetype 1 lw 2 title "Segment", \
 'data/sr_pre_PickupLoc_word_averaged.csv' using 2:3 smooth bezier linetype 2 lw 2 title "Word", \
 'data/sr_pre_PickupLoc_wordannotated_averaged.csv' using 2:3 smooth bezier linetype 3 lw 2 title "WA"