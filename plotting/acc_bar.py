import matplotlib
matplotlib.rcParams.update({'font.size': 20})
matplotlib.rc('text', usetex = True)

import matplotlib.pyplot as plt
import numpy as np


def base_acc_bar():
    ecolor_all = plt.get_cmap('tab20').colors
    base_col =       ecolor_all[6]
    new_col =        ecolor_all[0]
    new_col_alt =    ecolor_all[1]

    print("Creating acc bar")
    data = np.loadtxt('acc_bar_data.txt', delimiter=',', skiprows=1, usecols=range(1,9))
    baseline_avgs = data[0:5,[6]]
    baseline_stds = data[0:5,[7]]
    rl_aware_avgs = data[5:10, [0]]
    rl_aware_stds = data[5:10, [1]]
    aware_avgs = data[5:10, [6]]
    aware_stds = data[5:10, [7]]

    fig, ax = plt.subplots(figsize=(14,6))
    N = 5
    ind = np.arange(N)    # the x locations for the groups
    width = 0.15         # the width of the bars
    p1 = ax.bar(ind, baseline_avgs.flatten(), width, bottom=0, yerr=baseline_stds.flatten(), color=base_col)
    p2 = ax.bar(ind+width, rl_aware_avgs.flatten(), width, bottom=0, yerr=rl_aware_stds.flatten(), color=new_col)
    p2_retrained = ax.bar(ind+(width*2), aware_avgs.flatten(), width, bottom=0, yerr=aware_stds.flatten(), color=new_col_alt)

    ax.set_title('Online accuracy over different Levels')
    ax.set_xticks(ind + width / 2)
    ax.set_xticklabels((r'\textsc{Before}', r'\textsc{And}', r'\textsc{Mixed-2}', r'\textsc{Before(repeat)}', r'\textsc{Mixed-3}'))
    ax.xaxis.set_tick_params(size=8)
    ax.set_ylabel('Accuracy')
    ax.yaxis.set_label_coords(-0.07,0.5)
    ax.set_ylim([0,1])
    ax.legend((p1[0], p2[0], p2_retrained[0]), ('Baseline (retrained)', 'Aware in RL', 'Aware (retrained)'), loc='upper center', bbox_to_anchor=(0.5, -0.1),ncol=3, fancybox=True, shadow=True)
    plt.savefig("bar.png", bbox_inches='tight', transparent=True)


def sparse_acc_bar():
    ecolor_all = plt.get_cmap('tab20').colors
    base_col =       ecolor_all[6]
    new_col =        ecolor_all[0]
    new_col_alt =    ecolor_all[1]
    sparse_col =     ecolor_all[2]
    sparse_col_alt = ecolor_all[3]

    print("Creating sparse acc bar")
    data = np.loadtxt('sparse_acc_bar_data.txt', delimiter=',',skiprows=1, usecols=range(1,9))
    off_base_avgs = data[[0,1], [6]]
    off_base_stds = data[[0,1], [7]]
    rl_aware_avgs = data[[4,5], [0]]
    rl_aware_stds = data[[4,5], [1]]
    off_aware_avgs = data[[4,5], [6]]
    off_aware_stds = data[[4,5], [7]]
    rl_sparse_avgs = data[[2,3], [0]]
    rl_sparse_stds = data[[2,3], [1]]
    off_sparse_avgs = data[[2,3], [6]]
    off_sparse_stds = data[[2,3], [7]]

    fig, ax = plt.subplots(figsize=(10,6))
    N = 2
    ind = np.arange(N)    # the x locations for the groups
    width = 0.15         # the width of the bars

    p1 = ax.bar(ind, off_base_avgs.flatten(), width, bottom=0, yerr=off_base_stds.flatten(), color=base_col)
    p2 = ax.bar(ind+width, rl_aware_avgs.flatten(), width, bottom=0, yerr=rl_aware_stds.flatten(), color=new_col)
    p3 = ax.bar(ind+(width*2), off_aware_avgs.flatten(), width, bottom=0, yerr=off_aware_stds.flatten(), color=new_col_alt)
    p4 = ax.bar(ind+(width*3), rl_sparse_avgs.flatten(), width, bottom=0, yerr=rl_sparse_stds.flatten(), color=sparse_col)
    p5 = ax.bar(ind+(width*4), off_sparse_avgs.flatten(), width, bottom=0, yerr=off_sparse_stds.flatten(), color=sparse_col_alt)
    p_empty = ax.plot(np.NaN, np.NaN, '-', color='none', label='')

    ax.set_title('Sparse classification accuracy')
    ax.set_xticks(ind + (width*4) / 2)
    ax.set_xticklabels((r'\textsc{Before}', r'\textsc{Mixed-2}'))
    ax.xaxis.set_tick_params(size=8)
    ax.set_ylabel('Accuracy')
    ax.yaxis.set_label_coords(-0.09,0.5)
    ax.set_ylim([0,1])
    ax.legend((p1[0], p_empty[0], p2[0], p3[0], p4[0], p5[0]), ('Baseline (retrained)','', 'Aware in RL', 'Aware (retrained)', 'Sparse in RL', 'Sparse (retrained)'), loc='upper center', bbox_to_anchor=(0.5, -0.1),ncol=3, fancybox=True, shadow=True)
    plt.savefig("sparse_bar.png", bbox_inches='tight', transparent=True)


def main():
    base_acc_bar()
    sparse_acc_bar()



if __name__ == "__main__":
    main()