import matplotlib
matplotlib.rcParams.update({'font.size': 20, 'lines.markeredgewidth': 1, 'hatch.linewidth':0.2})
matplotlib.rc('text', usetex = True)

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

def single_stack(ax, ind, width, avgs, stds, capsize=5, offset=0.1, model='baseline',col_rows=[0,3,6]):
    color_all = plt.get_cmap('tab20').colors
    color0 = color_all[0]
    color1 = color_all[1]
    color2 = color_all[2]
    ecolor_all = plt.get_cmap('tab20c').colors
    ecolor0 = ecolor_all[1]
    ecolor1 = ecolor_all[0]
    ecolor2 = ecolor_all[4]

    locs = []
    if model == 'baseline':
        direc = -1
        hatch = None

        colobj_loc = ind+(direc*offset)
        obj_loc = ind+(direc*offset)+(direc*width)
        col_loc = ind+(direc*offset)+(direc*2*width)

        col      = ax.bar(col_loc, avgs[col_rows,0], width, bottom=0, ecolor=ecolor0 ,yerr=stds[col_rows,0], color=color0,capsize=capsize, hatch=hatch)
        col_fail = ax.bar(col_loc, avgs[col_rows,1], width, bottom=avgs[col_rows,0], ecolor=ecolor1 ,yerr=stds[col_rows,1], color=color1,capsize=capsize, hatch=hatch)
        col_time = ax.bar(col_loc, avgs[col_rows,2], width, bottom=avgs[col_rows,0]+avgs[col_rows,1], ecolor=ecolor2 ,yerr=stds[col_rows, 2], color=color2,capsize=capsize, hatch=hatch)

        obj =      ax.bar(obj_loc, avgs[col_rows+1,0], width, bottom=0, ecolor=ecolor0 ,yerr=stds[col_rows+1,0], color=color0,capsize=capsize, hatch=hatch)
        obj_fail = ax.bar(obj_loc, avgs[col_rows+1,1], width, bottom=avgs[col_rows+1,0], ecolor=ecolor1 ,yerr=stds[col_rows+1,1], color=color1,capsize=capsize, hatch=hatch)
        obj_time = ax.bar(obj_loc, avgs[col_rows+1,2], width, bottom=avgs[col_rows+1,0]+avgs[col_rows+1,1], ecolor=ecolor2 ,yerr=stds[col_rows+1,2], color=color2,capsize=capsize, hatch=hatch)

        colobj =      ax.bar(colobj_loc, avgs[col_rows+2,0], width, bottom=0, ecolor=ecolor0 ,yerr=stds[col_rows+2,0], color=color0,capsize=capsize, hatch=hatch)
        colobj_fail = ax.bar(colobj_loc, avgs[col_rows+2,1], width, bottom=avgs[col_rows+2,0], ecolor= ecolor1,yerr=stds[col_rows+2,1], color=color1,capsize=capsize, hatch=hatch)
        colobj_time = ax.bar(colobj_loc, avgs[col_rows+2,2], width, bottom=avgs[col_rows+2,0]+avgs[col_rows+2,1], ecolor=ecolor2 ,yerr=stds[col_rows+2,2], color=color2,capsize=capsize, hatch=hatch)

        # minor x ticks on bar locations
        locs = sorted([x for l in [colobj_loc, obj_loc, col_loc] for x in l])

    elif model == 'aware':
        hatch = '/'
        direc = 1
        col_loc = ind+(direc*offset)
        obj_loc = ind+(direc*offset)+(direc*width)
        colobj_loc = ind+(direc*offset)+(direc*2*width)

        col      = ax.bar(col_loc, avgs[col_rows,0], width, bottom=0, ecolor=ecolor0 ,yerr=stds[col_rows,0], color=color0,capsize=capsize)
        col_fail = ax.bar(col_loc, avgs[col_rows,1], width, bottom=avgs[col_rows,0], ecolor=ecolor1 ,yerr=stds[col_rows,1], color=color1,capsize=capsize)
        col_time = ax.bar(col_loc, avgs[col_rows,2], width, bottom=avgs[col_rows,0]+avgs[col_rows,1], ecolor=ecolor2 ,yerr=stds[col_rows,2], color=color2,capsize=capsize)

        obj =      ax.bar(obj_loc, avgs[col_rows+1,0], width, bottom=0, ecolor=ecolor0 ,yerr=stds[col_rows+1,0], color=color0,capsize=capsize)
        obj_fail = ax.bar(obj_loc, avgs[col_rows+1,1], width, bottom=avgs[col_rows+1,0], ecolor=ecolor1 ,yerr=stds[col_rows+1,1], color=color1,capsize=capsize)
        obj_time = ax.bar(obj_loc, avgs[col_rows+1,2], width, bottom=avgs[col_rows+1,0]+avgs[col_rows+1,1], ecolor=ecolor2 ,yerr=stds[col_rows+1,2], color=color2,capsize=capsize)

        colobj =      ax.bar(colobj_loc, avgs[col_rows+2,0], width, bottom=0, ecolor=ecolor0 ,yerr=stds[col_rows+2,0], color=color0,capsize=capsize)
        colobj_fail = ax.bar(colobj_loc, avgs[col_rows+2,1], width, bottom=avgs[col_rows+2,0], ecolor=ecolor1 ,yerr=stds[col_rows+2,1], color=color1,capsize=capsize)
        colobj_time = ax.bar(colobj_loc, avgs[col_rows+2,2], width, bottom=avgs[col_rows+2,0]+avgs[col_rows+2,1], ecolor=ecolor2 ,yerr=stds[col_rows+2,2], color=color2,capsize=capsize)

        locs = sorted([x for l in [colobj_loc, obj_loc, col_loc] for x in l])


    bars = []

    bars.append((col, col_fail, col_time))
    bars.append((obj, obj_fail, obj_time))
    bars.append((colobj, colobj_fail, colobj_time))
    return bars, locs

def make_plot(mode='simple'):
    if mode == 'simple':
        data = pd.read_csv('rate_data_base_simple.txt', delimiter=',', header=None).to_numpy()
        xind1 = 9
        N = 3
        columns = [r'\textsc{Before}', r'\textsc{And}', r'\textsc{Mixed-2}']
        fig, ax = plt.subplots(figsize=(15,9))
        ax.set_title('Termination reason per level in simple levels')
        y_dist = 0.05

    else:
        xind1 = 6
        N = 2
        columns = [r'\textsc{Before(repeat)}', r'\textsc{Mixed-3}']
        data = pd.read_csv('rate_data_base_complex.txt', delimiter=',', header=None).to_numpy()
        fig, ax = plt.subplots(figsize=(10,9))
        ax.set_title('Termination reason per level in complex levels')
        y_dist = 0.09


    baseline_avgs = data[0:xind1,[0,2,4]]
    baseline_stds = data[0:xind1,[1,3,5]]
    aware_avgs = data[xind1:xind1*2, [0,2,4]]
    aware_stds = data[xind1:xind1*2, [1,3,5]]

    ind = np.arange(N)    # the x locations for the groups
    width = 0.1          # the width of the bars

    col_rows = np.array(range(0,xind1, 3))
    bars, base_bar_idx = single_stack(ax, ind, width, baseline_avgs, baseline_stds, col_rows=col_rows)
    bars, aware_bar_idx = single_stack(ax, ind, width, aware_avgs, aware_stds, col_rows=col_rows, model='aware')
    ax.set_xticks(ind)
    rows = ['Success', 'Fail', 'Timeout']
    ax.set_xticklabels(columns)
    ax.tick_params(axis='x', which='major', pad=100, size=0)

    idx = sorted(base_bar_idx + aware_bar_idx)
    ax.xaxis.set_minor_locator(matplotlib.ticker.FixedLocator(idx))
    xtick_labels = ['Color', 'Object', 'Color+Object'] * 2 * 3
    ax.xaxis.set_minor_formatter(matplotlib.ticker.FixedFormatter(xtick_labels))
    plt.setp(ax.xaxis.get_minorticklabels(), rotation=60, ha='right')
    for tick in ax.xaxis.get_minor_ticks():
            tick.label.set_fontsize(16)
    for tick in ax.xaxis.get_major_ticks():
            tick.label.set_fontsize(28)



    # ax.xaxis.set_tick_params(size=8, pad=10)
    ax.set_ylabel('Ratio')
    ax.set_ylim([0,1.2])
    ax.yaxis.set_label_coords(-y_dist,0.5)

    ax.legend(
        (bars[0][0][0],bars[0][1][0], bars[0][2][0]),
        rows,
        loc='upper center',
        bbox_to_anchor=(0.5, 1),
        ncol=3,
        fancybox=True,
        shadow=True
    )

    # all_stds = np.array([baseline_stds[0:3, :], aware_stds[0:3, :], baseline_stds[3:6,:], aware_stds[3:6,:], baseline_stds[6:9,:],aware_stds[6:9,:]])
    # print(all_stds)
    # the_table = plt.table(cellText=np.flip(all_stds.transpose(), 0),
    #                     rowLabels=['Std time','Std fail', 'std success'],
    #                     rowColours=['C2','C1','C0'],
    #                     # colLabels=columns,
    #                     loc='bottom',
    #                     bbox=[-0.01, -0.5, 1, 0.3])
    # plt.subplots_adjust(left=0.2, bottom=0.2)

    plt.savefig(f"base_stack_{mode}.png", bbox_inches='tight')


def main():
    make_plot('simple')
    make_plot('complex')


if __name__ == "__main__":
    main()