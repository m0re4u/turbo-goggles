import argparse
from collections import Counter
import gym
from tqdm import tqdm

from babyai.utils.format import Vocabulary
from segment import Segmenter

def main(args):
    c = Counter()
    for lvl in tqdm(args.env):
        segment_level(c, lvl)

    print(f"{len(c)} unique segments")
    for k, v in c.most_common(len(c)):
        print(f"{k:80} : {v/(args.n_missions * len(args.env))}")


def segment_level(counter, level_name):
    env = gym.make(level_name)
    segger = Segmenter(level_name, args.segment_level)

    for _ in tqdm(range(args.n_missions)):
        obs = env.reset()
        sent = obs['mission']
        segs = segger.segment(sent)
        counter.update(segs)



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--env", required=True, nargs='+',
                        help="name of the environment(s) to be run (REQUIRED)")
    parser.add_argument("--segment_level", type=str, default='segment',
                        choices=['word', 'segment'],
                        help="segment on word or clause level")
    parser.add_argument("--n_missions", type=int, default=100,
                        help="how many missions to sample")
    args = parser.parse_args()
    main(args)
