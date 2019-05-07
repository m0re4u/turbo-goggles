set term png
set output ARG1

set key autotitle columnhead
set key bottom right
set datafile separator comma

set style line 1 lc 1 lt 1
set style line 2 lc 2 lt 2
set style line 3 lc 3 lt 3
set style line 4 lc 4 lt 4
set style line 5 lc 5 lt 5
set style increment user

set title "Episode length during training for file:" noenhanced
set xlabel "Number of training iterations"
set ylabel "Mean episode length"
set yrange [0:1.1]


filelist=system("ls data/*_succes_rate.csv")
i = 1
plot 1 title "100% succes"
do for [filename in filelist] {
    replot filename using 2:3 smooth bezier title filename noenhanced
    print filename
    i = i + 1
}
# plot for [filename in filelist] filename using 2:3 with lp lw 0.1 lc rgb "#AA0000AA" title filename noenhanced
    #  for [filename in filelist] '' using 2:3 smooth bezier lw 3 title ""
