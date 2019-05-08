import argparse
import numpy as np


def main(args):
    files = []
    for id in args.jobids:
        if args.sr:
            file = f"../plotting/data/agg_{id}_succes_rate.csv"
        else:
            file = f"../plotting/data/agg_{id}_episode_length.csv"
        files.append(file)
    if files == []:
        raise FileNotFoundError(f"Error finding files for {args.jobids}")

    # Load data from each file and keep data until shortest file length
    mats = [np.loadtxt(f, skiprows=1, delimiter=',') for f in files]
    min_length = min([x.shape[0] for x in mats])
    eq_ms = [mat[:min_length, 2] for mat in mats]

    # Average every point
    avg_m = np.average(eq_ms, axis=0)

    # Recreate file format for plotting
    out = np.zeros((min_length, 3))
    out[:, -1] = avg_m
    out[:, 1] = np.arange(min_length)

    # Output file
    if args.sr:
        output_file = f"sr_pre_{args.level}_{args.segment_level}_averaged.csv"
    else:
        output_file = f"el_pre_{args.level}_{args.segment_level}_averaged.csv"
    np.savetxt(output_file, out, delimiter=",",
               header="Wall time,Step,Value", fmt="%g")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("jobids", type=str, nargs="+",
                        help="input job ids to find CSVs for")
    parser.add_argument("--level", type=str, required=True,
                        help="level data to average")
    parser.add_argument('--segment_level', type=str, default='word', choices=['word', 'segment', 'wordannotated'],
                        help='Segmentation level')
    parser.add_argument('--sr', action='store_true',
                        help="average succes rate (True) or episode length (False)")

    args = parser.parse_args()
    main(args)
