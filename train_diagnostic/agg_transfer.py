import os
import argparse
import numpy as np

from itertools import product
from collections import defaultdict

TABLES = ['base', 'zero', 'trained_transfer']
LVLS = ['small', 'beforeafter', 'and']
MODELS = ['new', 'base']
TMODE = ['color', 'obj', 'colobj']
NSEEDS = [1, 2, 3]


def fill_results(filenames, table=None):
    result_dict = {}
    if table == 'base':
        model_generator = product(LVLS, MODELS)
        name_idx = [0,1]
    elif table == 'zero':
        model_generator = product(LVLS, MODELS, TMODE)
        name_idx = [1,0,3]
    elif table == 'trained_transfer':
        model_generator = product(LVLS, MODELS, TMODE)
        name_idx = [0,1,3]
    else:
        print("Unknown table, exiting")
        exit(1)

    # Create empty result dict
    for m in model_generator:
        mname = "_".join(m)
        result_dict[mname] = {
                'eps': [],
                'suc': [],
                'fail': [],
                'time': [],
                'frames': []
        }

    # Fill dict with results from file
    for filename in filenames:
        with open(filename, 'r') as f:
            for line in f:
                spl = line.split(',')
                name = spl[-1]
                n_spl = name.split('_')
                mkey = "_".join([n_spl[i] for i in name_idx])
                result_dict[mkey]['frames'].append(float(spl[0].strip()))
                result_dict[mkey]['eps'].append(float(spl[2].strip()))
                result_dict[mkey]['suc'].append(float(spl[3].strip()))
                result_dict[mkey]['fail'].append(float(spl[4].strip()))
                result_dict[mkey]['time'].append(float(spl[5].strip()))

    return result_dict

def print_results(results):
    print()
    print("MODEL,FRAMES,EP_AVG,EP_STD,SUC_AVG,SUC_STD,FAIL_AVG,FAIL_STD,TIME_AVG,TIME_STD")
    for k, v in results.items():
        if len(v['frames']) == 0:
            continue
        # sum frames, average + std other four metrics
        ep_avg, ep_std = get_stats(v['eps'])
        suc_avg, suc_std = get_stats(v['suc'])
        fail_avg, fail_std = get_stats(v['fail'])
        time_avg, time_std = get_stats(v['time'])
        print(
            f"{k},{np.sum(v['frames']):.0f},{ep_avg:.2f},{ep_std:.2f},{suc_avg},{suc_std},{fail_avg},{fail_std},{time_avg},{time_std}")

def agg_diag(rl_filename, train_filename, eval_filename):
    results = defaultdict(lambda: {'acc_rl':[],'acc_train':[],'acc_val':[],'acc_online':[]})
    # create datasets file
    with open(rl_filename) as f:
        for line in f:
            spl = line.split(',')
            split_name = spl[-1].split('_')
            key = "_".join(split_name[0:2])
            results[key]['acc_rl'].append(float(spl[1]))
    # train diags file
    with open(train_filename, 'r') as f:
        for line in f:
            spl = line.split(',')
            split_name = spl[0].split('_')
            key = "_".join(split_name[0:2])
            results[key]['acc_train'].append(float(spl[1]))
            results[key]['acc_val'].append(float(spl[2]))
    # eval diags file
    with open(eval_filename) as f:
        for line in f:
            spl = line.split(',')
            split_name = spl[-1].split('_')
            key = "_".join(split_name[0:2])
            results[key]['acc_online'].append(float(spl[1]))

    print("MODEL,RL MEAN,RL STD,OFF TRAIN MEAN,OFF TRAIN STD,OFF VAL MEAN,OFF VAL STD,ON MEAN,ON STD")
    for k,v in results.items():
        rl_mean, rl_std = get_stats(v['acc_rl'])
        train_mean, train_std = get_stats(v['acc_train'])
        val_mean, val_std = get_stats(v['acc_val'])
        online_mean, online_std = get_stats(v['acc_online'])
        print(f"{k},{rl_mean},{rl_std},{train_mean},{train_std},{val_mean},{val_std},{online_mean},{online_std}")


def main(args):
    fnames = []
    if args.table == 'base':
        # Aggregate results from other base performances as well:
        # - eval_diags
        # - train_diags

        agg_diag(f'create_datasets_{args.episodes}.log', f'train_diags_{args.epochs}.log', f'eval_diags_{args.episodes}.log')
        fnames = [f'create_datasets_{args.episodes}.log']
    elif args.table == 'zero':
        for lvlname in LVLS:
            fname = f'transfer_eval_{args.episodes}_{lvlname}.log'
            if not os.path.exists(fname):
                continue
            fnames.append(fname)
    elif args.table == 'trained_transfer':
        for lvlname in LVLS:
            fname = f'trained_transfer_eval_{args.episodes}_{lvlname}.log'
            if not os.path.exists(fname):
                continue
            fnames.append(fname)

    # Fill the results from eval_rl
    result_dict = fill_results(fnames, table=args.table)

    # Pretty print for copying
    print_results(result_dict)

def get_stats(arr):
    return np.average(arr), np.std(arr)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--table", default=None, help="Table name")
    parser.add_argument("--episodes",type=int, default=100, help="Number of episodes that were evaluated")
    parser.add_argument("--epochs",type=int, default=10, help="Number of epochs that the diagnostic classifiers were trained with")
    args = parser.parse_args()
    if args.table is None or args.table not in TABLES:
        print("Specify a (correct) table name to aggregate results for!")
        exit(1)
    else:
        main(args)
