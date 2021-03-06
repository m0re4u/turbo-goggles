import argparse
import json
import re
from pathlib import Path

import matplotlib.pyplot as plt
import matplotlib
matplotlib.rcParams.update({'font.size': 20})
matplotlib.rc('text', usetex = True)
import numpy as np


def smooth(x, N):
    cumsum = np.cumsum(np.insert(x, 0, 0))
    return (cumsum[N:] - cumsum[:-N]) / float(N)


def get_data(id, mode, data_dir):
    if id.isdigit():
        # Valid id, get the associated file
        if mode == "el":
            file = Path(data_dir, f"agg_{id}_episode_length.csv")
            ylabel = "Mean episode length"
        elif mode == "sr":
            file = Path(data_dir, f"agg_{id}_succes_rate.csv")
            ylabel = "Mean succes rate"
    else:
        # Not a valid id, assume it is a filename for the averaged runs
        if mode == "el":
            file = Path(data_dir, f"el_{id}.csv")
            ylabel = "Mean episode length"
        elif mode == "sr":
            file = Path(data_dir, f"sr_{id}.csv")
            ylabel = "Mean succes rate"

    return file, ylabel


def create_plot(plot, data_dir="data/", result_dir="results/", show=False, mode="el"):
    if mode == "el":
        title = f"Episode Length {plot['title']}"
    else:
        title = f"Success Rate {plot['title']}"
    plt.figure(figsize=(10,4))
    plt.title(title)
    if 'style' in plot:
        if 'xlim' in plot['style'][mode]:
            plt.xlim(*plot['style'][mode]['xlim'])
        if 'ylim' in plot['style'][mode]:
            plt.ylim(*plot['style'][mode]['ylim'])

    for i, id in enumerate(plot['ids']):
        file, ylabel = get_data(id, mode, data_dir)
        data = np.loadtxt(file, skiprows=1, delimiter=',')

        if 'linestyles' in plot and plot['linestyles'][i] == 'dashed':
            dash = [6,2]
        else:
            dash = (None, None)
        if 'std' in plot and plot['std'] is True:
            sigma=data[:, 3]
            mu=smooth(data[:, 2], plot['smoothing'])
            x = np.arange(mu.shape[0])
            top = smooth(data[:, 2]+sigma, plot['smoothing'])
            bottom = smooth(data[:, 2]-sigma, plot['smoothing'])
            plt.plot(smooth(mu, plot['smoothing']), label=plot['keys'][i],dashes=dash, linewidth=2,)
            plt.fill_between(x,bottom, top, alpha=0.5)
        else:
            plt.plot(smooth(data[:, -1], plot['smoothing']), label=plot['keys'][i],dashes=dash, linewidth=2)

    plt.ylabel(ylabel)
    plt.xlabel("Number of training iterations")
    plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), ncol=2, fancybox=True, shadow=True)
    if show:
        plt.show()
    else:
        out = re.sub("[ -]+", "_", title.lower())
        plt.savefig(Path(result_dir, out), bbox_inches='tight')


def main(args):
    with open(args.cfg, 'r') as f:
        obj = json.load(f)

    for plot in obj['plots']:
        print(f"Creating {plot['title']}")
        create_plot(plot, data_dir=args.data_dir,
                    result_dir=args.result_dir, show=args.show, mode="el")
        create_plot(plot, data_dir=args.data_dir,
                    result_dir=args.result_dir, show=args.show, mode="sr")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--cfg", type=str, default="plots.json",
                        help="Input config file for to be created plots")
    parser.add_argument("--data_dir", type=str, default="data/",
                        help="Pulled tensorboard data directory")
    parser.add_argument("--result_dir", type=str, default="results/",
                        help="Output directory for plots")
    parser.add_argument("--show", action='store_true', default=False,
                        help="Show interactive plot instead of saving to png")
    args = parser.parse_args()

    Path(args.data_dir).mkdir(exist_ok=True)
    Path(args.result_dir).mkdir(exist_ok=True)

    main(args)
