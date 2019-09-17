import argparse
import os

import matplotlib
matplotlib.rcParams.update({'font.size': 22})
matplotlib.rc('text', usetex = True)

import matplotlib.pyplot as plt
from matplotlib import cm
import numpy as np


def main(args):
    plt.clf()
    for file in os.listdir(args.data_dir):
        if not file.endswith('.log'):
            continue
        fig, ax = plt.subplots(nrows=1, ncols=1, figsize=(6,6))
        W = np.loadtxt(os.path.join(args.data_dir, file))
        X_size, Y_size = W.shape
        aa = ax
        aa.imshow(W)
        aa.set_title(f'{file.strip(".log").replace("_"," ")}')
        aa.set_xlabel(r'Predictions')
        aa.set_ylabel(r'True reason', rotation=90)
        aa.set_ylim(-0.5, Y_size-0.5)
        aa.set_xlim(-0.5, X_size-0.5)
        aa.set_xticks(np.arange(X_size))
        aa.xaxis.set_tick_params(labelsize=18)
        aa.yaxis.set_tick_params(labelsize=18)
        aa.set_yticks(np.arange(Y_size))
        plt.savefig(f'{os.path.join(args.data_dir,file.strip(".log"))}.png', bbox_inches='tight')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument('--data_dir', default='confusions',
                        help='directory containing confusion matrix data')
    args = parser.parse_args()
    main(args)
