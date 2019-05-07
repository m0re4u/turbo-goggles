set term png
set output 'results/sr_pretrain_PutNextLocal.png'

set key bottom right
set datafile separator comma

set title "Succes rate during training on PutNextLocal (pretrained on GoToLocal)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean succes rate"
set yrange [0:1.1]

plot 1 title "100% succes", \
 'data/agg_2266462_succes_rate.csv' using 2:3 smooth bezier linetype 1 lw 2 title "Segment", \
 'data/agg_2265470_succes_rate.csv' using 2:3 smooth bezier linetype 2 lw 2 title "Word", \
 'data/agg_2266463_succes_rate.csv' using 2:3 smooth bezier linetype 3 lw 2 title "WA"