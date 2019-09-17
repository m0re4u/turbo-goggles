import matplotlib
matplotlib.rcParams.update({'font.size': 20})
matplotlib.rc('text', usetex = True)

import matplotlib.pyplot as plt
import numpy as np


def main():
    data = np.loadtxt('off_curve_data.txt', delimiter=',')
    print(data)
    fig, ax = plt.subplots(figsize=(14,6))
    N = data.shape[1]
    print(N)
    p1 =     ax.plot(np.arange(N), data[0,:], '-.s')   # train
    p1_val = ax.plot(np.arange(N), data[1,:], '-.*')   # val
    p2 =     ax.plot(np.arange(N), data[2,:], '-s')   # train
    p2_val = ax.plot(np.arange(N), data[3,:], '-*')   # val

    ax.set_title('Accuracy progress in offline training')
    ax.set_ylabel('Accuracy')
    ax.yaxis.set_label_coords(-0.07,0.5)
    ax.xaxis.set_label_coords(0.5,-0.1)
    ax.set_xlabel('Offline epochs')
    ax.set_ylim([0,1])
    ax.legend((p1[0], p1_val[0], p2[0],p2_val[0]), ('Baseline (train)', 'Baseline (val)', 'Aware (train)', 'Aware (val)'), loc='upper left',ncol=2, fancybox=True, shadow=True)
    plt.savefig("curve.png", bbox_inches='tight', transparent=True)



if __name__ == "__main__":
    main()