import argparse
import pandas as pd
import pathlib
from tensorboard.backend.event_processing.event_accumulator import EventAccumulator


def main(filename, out_prefix):
    evt = EventAccumulator(filename).Reload()
    keys = evt.scalars.Keys()

    relevant_keys = ['train/succes_rate', 'train/episode_length']
    for key in relevant_keys:
        data_to_csv(key, evt.scalars.Items(key), out_prefix)


def data_to_csv(key, data, output_prefix):
    tab = [list(scalar) for scalar in data]
    df = pd.DataFrame(tab, columns=["Wall time", "Step", "Value"])
    key = key.replace("train/", "")
    outfile = f"{output_prefix}_{key}.csv"
    pathlib.Path(outfile).parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(outfile, index=False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("filename", type=str,
                        help="Tensorboard run file")
    parser.add_argument("output_prefix", type=str,
                        help="Output prefix for generated csv files")
    args = parser.parse_args()
    main(args.filename, args.output_prefix)
