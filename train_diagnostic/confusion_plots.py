import argparse
import os

import matplotlib.pyplot as plt
import numpy as np


def main(args):
    for file in os.listdir(args.data_dir):
        if not file.endswith('.log'):
            continue
        plt.clf()
        W = np.loadtxt(os.path.join(args.data_dir, file))
        X_size, Y_size = W.shape
        plt.imshow(W)
        plt.xlabel(r'predictions $\rightarrow$')
        plt.ylabel(r'true reason $\rightarrow$', rotation=90)
        plt.xticks(np.arange(X_size))
        plt.yticks(np.arange(Y_size))
        plt.colorbar()
        plt.savefig(f'{os.path.join(args.data_dir,file.strip(".log"))}.png')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument('--data_dir', default='confusions',
                        help='directory containing confusion matrix data')
    args = parser.parse_args()
    main(args)
