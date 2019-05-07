set term png
set output 'results/sr_no_pretrain_GoToLocal42.png'

set key bottom right
set datafile separator comma

set title "Succes rate during training on GoToLocal (no pretraining)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean succes rate"
set yrange [0:1.1]

plot 1 title "100% succes", \
 'data/nopre_GoToLocal_segment_averaged.csv' using 2:3 smooth bezier linetype 1 lw 2 title "Segment", \
 'data/nopre_GoToLocal_words_averaged.csv' using 2:3 smooth bezier linetype 2 lw 2 title "Word", \
 'data/nopre_GoToLocal_wordsannotated_averaged.csv' using 2:3 smooth bezier linetype 3 lw 2 title "WA"