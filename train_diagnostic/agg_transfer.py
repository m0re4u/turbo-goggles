import argparse
import numpy as np

from itertools import product


LVLS = ['small', 'beforeafter', 'andor']
MODELS = ['new', 'base']
TMODE = ['color', 'obj', 'colobj']
NSEEDS = [1, 2, 3]


def main(args):
    result_dict = {}
    if args.baseline:
        for model, level in product(LVLS, MODELS):
            mname = f"{model}_{level}"
            result_dict[mname] = {
                'eps': [],
                'suc': [],
                'fail': [],
                'time': [],
                'frames': []
            }
    else:
        for model, level, tmode in product(LVLS, MODELS, TMODE):
            mname = f"{level}_{model}_{tmode}"
            result_dict[mname] = {
                'eps': [],
                'suc': [],
                'fail': [],
                'time': [],
                'frames': []
            }

    print(result_dict.keys())
    with open(args.filename, 'r') as f:
        for line in f:
            spl = line.split(',')
            name = spl[-1]
            n_spl = name.split('_')
            if args.baseline:
                mkey = f"{n_spl[0]}_{n_spl[1]}"
            else:
                mkey = f"{n_spl[0]}_{n_spl[1]}_{n_spl[3]}"
            print(mkey)
            result_dict[mkey]['frames'].append(float(spl[0].strip()))
            result_dict[mkey]['eps'].append(float(spl[2].strip()))
            result_dict[mkey]['suc'].append(float(spl[3].strip()))
            result_dict[mkey]['fail'].append(float(spl[4].strip()))
            result_dict[mkey]['time'].append(float(spl[5].strip()))

    print(result_dict)
    for k, v in result_dict.items():
        if len(v['frames']) == 0:
            continue
        # sum frames, average + std other four metrics
        ep_avg, ep_std = get_stats(v['eps'])
        suc_avg, suc_std = get_stats(v['suc'])
        fail_avg, fail_std = get_stats(v['fail'])
        time_avg, time_std = get_stats(v['time'])
        print(
            f"{k},{np.sum(v['frames'])},{ep_avg},{ep_std},{suc_avg},{suc_std},{fail_avg},{fail_std},{time_avg},{time_std}")


def get_stats(arr):
    return np.average(arr), np.std(arr)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--filename", type=str, default="transfer_eval_100.log",
                        help="")
    parser.add_argument("--baseline", default=False, action='store_true',help="run in baseline mode")
    args = parser.parse_args()
    main(args)
