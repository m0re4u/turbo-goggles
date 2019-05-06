set term png
set output 'test.png'
set key top left
set datafile separator comma

set title  "Mean success rate on PutNextLocal during training"
set xlabel "Number of training frames"
set ylabel "Mean succes rate"

plot 'data/pretrained.csv' using ($2 * 2560):3 with lp lw 0.1 lc rgb "#77000000" title "", \
                   '' using ($2 * 2560):3 smooth bezier lw 3 title "Pretrained", \
        'data/scratch.csv' using ($2 * 2560):3 with lp lw 0.1 lc rgb "#00000000" title "", \
                   '' using ($2 * 2560):3 smooth bezier lw 3 title "From scratch"