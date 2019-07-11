import argparse
import json
import re
from pathlib import Path

import matplotlib.pyplot as plt
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
    title = f"{plot['title']}_{mode}"
    plt.figure()
    plt.title(title)
    plt.gcf().text(0, 0.01, plot['ids'], fontsize=8)
    if 'xlim' in plot:
        plt.xlim(*plot['xlim'])
    for i, id in enumerate(plot['ids']):
        file, ylabel = get_data(id, mode, data_dir)
        data = np.loadtxt(file, skiprows=1, delimiter=',')
        plt.plot(smooth(data[:, -1], plot['smoothing']), label=plot['keys'][i])
    plt.ylabel(ylabel)
    plt.xlabel("Number of training iterations")
    plt.legend()
    if show:
        plt.show()
    else:
        out = re.sub("[ -]+", "_", title.lower())
        plt.savefig(Path(result_dir, out))


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
