import argparse
from collections import Counter
import gym

import babyai

from segment import Segment

def main(args):
    env = gym.make(args.env)
    c = Counter()
    for _ in range(args.n_missions):
        obs = env.reset()
        sent = obs['mission']
        print(f"Mission: {sent}")
        sent_list = sent.split()
        cmd, obj1, loc, obj2 = segment_mission(sent)
        c.update([cmd, obj1, loc, obj2])
    print(c)


def segment_mission(instruction):
    instruction_list = instruction.split()
    cmd = instruction_list[:1]
    obj1 = instruction_list[1:4]
    loc = instruction_list[4:6]
    obj2 = instruction_list[6:]
    return Segment(cmd), Segment(obj1), Segment(loc), Segment(obj2)



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--env", required=True,
                        help="name of the environment to be run (REQUIRED)")
    parser.add_argument("--n_missions", type=int, default=100,
                        help="name of the environment to be run (REQUIRED)")
    args = parser.parse_args()
    main(args)
