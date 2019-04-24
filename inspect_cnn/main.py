import argparse

import torch

from machine.models import SkillEmbedding

def main(args):
    state = torch.load(args.model, map_location=torch.device('cpu'))
    model = SkillEmbedding(*state['model_params'])
    print(state['model_params'])



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", required=True, type=str,
                        help="name of the model to check (REQUIRED)")
    args = parser.parse_args()
    main(args)
