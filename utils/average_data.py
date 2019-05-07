import argparse
import numpy as np

def main(args):
    mats = [np.loadtxt(f, skiprows=1, delimiter=',') for f in args.files]
    min_length = min([x.shape[0] for x in mats])
    eq_ms = [mat[:min_length, 2] for mat in mats]
    avg_m = np.average(eq_ms, axis=0)

    out = np.zeros((min_length, 3))
    out[:,-1] = avg_m
    out[:, 1] = np.arange(min_length)
    np.savetxt(args.output_file, out, delimiter=",", header="Wall time,Step,Value", fmt="%g")




if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("files", type=str, nargs="+",
                        help="input CSV data")
    parser.add_argument("--output_file", type=str, default="out.csv",
                        help="Output averaged CSV filename")
    args = parser.parse_args()
    main(args)
