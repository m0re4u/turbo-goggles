import matplotlib
matplotlib.rcParams.update({'font.size': 20})
matplotlib.rc('text', usetex = True)

import matplotlib.pyplot as plt
import numpy as np


def main():
    data = np.loadtxt('acc_bar_data.txt', delimiter=',', skiprows=1, usecols=range(1,9))
    print(data)
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
    p1 = ax.bar(ind, baseline_avgs.flatten(), width, bottom=0, yerr=baseline_stds.flatten())
    p2 = ax.bar(ind+width, rl_aware_avgs.flatten(), width, bottom=0, yerr=rl_aware_stds.flatten())
    p2_retrained = ax.bar(ind+(width*2), aware_avgs.flatten(), width, bottom=0, yerr=aware_stds.flatten())

    ax.set_title('Online accuracy over different Levels')
    ax.set_xticks(ind + width / 2)
    ax.set_xticklabels((r'\textsc{Before}', r'\textsc{And}', r'\textsc{Mixed-2}', r'\textsc{Before(repeat)}', r'\textsc{Mixed-3}'))
    ax.xaxis.set_tick_params(size=8)
    ax.set_ylabel('Accuracy')
    ax.yaxis.set_label_coords(-0.07,0.5)
    ax.set_ylim([0,1])
    ax.legend((p1[0], p2[0], p2_retrained[0]), ('Baseline (retrained)', 'Aware in RL', 'Aware (retrained)'), loc='upper center', bbox_to_anchor=(0.5, -0.1),ncol=3, fancybox=True, shadow=True)
    plt.savefig("bar.png", bbox_inches='tight', transparent=True)

    # data = np.loadtxt('sparse_acc_bar_data.txt', delimiter=',')
    # print(data)
    # rl_aware_avgs = data[[0,2], 0]
    # offline_aware_avgs = data[[0,2], 2]
    # rl_sparse_avgs = data[[1,3], 0]
    # offline_sparse_avgs = data[[1,3], 2]

    # fig, ax = plt.subplots(figsize=(10,6))
    # N = 2
    # ind = np.arange(N)    # the x locations for the groups
    # width = 0.15         # the width of the bars
    # p1 = ax.bar(ind-width, rl_aware_avgs.flatten(), width, bottom=0)
    # p1_off = ax.bar(ind, offline_aware_avgs.flatten(), width, bottom=0)
    # p2 = ax.bar(ind+(width*1), rl_sparse_avgs.flatten(), width, bottom=0)
    # p2_off = ax.bar(ind+(width*2), offline_sparse_avgs.flatten(), width, bottom=0)

    # ax.set_title('Sparse classification accuracy')
    # ax.set_xticks(ind + width / 2)
    # ax.set_ylim([0,1])
    # ax.set_xticklabels((r'\textsc{Before}', r'\textsc{Mixed-2}'))
    # ax.set_ylabel('Accuracy')
    # ax.legend((p1[0], p1_off[0], p2[0], p2_off[0]), ('Aware in RL', 'Aware (offline)', 'Sparse in RL', 'Sparse (offline)'), loc='upper center', bbox_to_anchor=(0.5, -0.1),ncol=2, fancybox=True, shadow=True)
    # plt.savefig("sparse_bar.png", bbox_inches='tight')



if __name__ == "__main__":
    main()