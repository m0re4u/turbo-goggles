set term png
set output 'results/sr_no_pretrain_GoToLocal.png'

set key bottom right
set datafile separator comma

set title "Succes rate during training on GoToLocal (no pretraining)" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean succes rate"
set yrange [0:1.1]

plot 1 title "100% succes", \
 'data/agg_2238716_succes_rate.csv' using 2:3 smooth bezier linetype 1 lw 2 title "Segment", \
 'data/agg_2239329_succes_rate.csv' using 2:3 smooth bezier linetype 2 lw 2 title "Word", \
 'data/agg_2239330_succes_rate.csv' using 2:3 smooth bezier linetype 3 lw 2 title "WA"


# plot for [filename in filelist] filename using 2:3 with lp lw 0.1 lc rgb "#AA0000AA" title filename noenhanced
    #  for [filename in filelist] '' using 2:3 smooth bezier lw 3 title ""
