import argparse
from collections import Counter
import gym

import babyai

from segment import Segmenter

def main(args):
    env = gym.make(args.env)
    c = Counter()
    segger = Segmenter(args.segment_level)

    for _ in range(args.n_missions):
        obs = env.reset()
        sent = obs['mission']
        print(f"Mission: {sent}")
        sent_list = sent.split()
        segs = segger.segment(sent)
        c.update(segs)

    print(f"{len(c)} unique segments")
    for k, v in c.most_common(len(c)):
        print(f"{k:80} : {v/args.n_missions}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--env", required=True,
                        help="name of the environment to be run (REQUIRED)")
    parser.add_argument("--segment_level", type=str, default='segment',
                        choices=['word', 'segment'],
                        help="segment on word or clause level")
    parser.add_argument("--n_missions", type=int, default=100,
                        help="how many missions to sample")
    args = parser.parse_args()
    main(args)
