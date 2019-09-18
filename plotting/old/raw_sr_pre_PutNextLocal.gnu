set term png
set output 'results/raw/PutNextLocal_sr_segment.png'

set key bottom right
set datafile separator comma

set title "RAW Succes rates during training on PutNextLocal (pretrained on GoToLocal)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean succes rate"
set yrange [0:1.1]

plot 1 title "100% succes", \
 'data/agg_2268403_succes_rate.csv' using 2:3 smooth bezier linetype 1 lw 2 title "segment1", \
 'data/agg_2266462_succes_rate.csv' using 2:3 smooth bezier linetype 2 lw 2 title "segment42"
