![logo](goggles.png)
# turbo-goggles
Utility repo for my master thesis at the University of Amsterdam.
Rest of my implementation is found in [machine](https://github.com/m0re4u/machine).

## BabyAI treegen
Segmenter to analyze the Baby language from [BabyAI](https://arxiv.org/abs/1810.08272).

Required packages:
- gym
- tqdm
- babyai

## Inspect CNN
Scripts to do some introspection in trained CNN models in the BabyAI setting.

Required packages:
- PyTorch
- machine


## Option Critic
Option-Critic implementation from [here](https://alversafa.github.io/blog/2018/11/28/optncrtc.html), adjusted for my needs.

Required packages:
- numpy
- matplotlib
- scipy


## Plotting
GNUplot scripts for visualizing the performance of my models.


## Utils
Some extra utilities:
- `replace_infile.sh` loops over (SLURM output) files and tries to replace some text inside each file.
- `pull_jobs.sh` connects to Lisa, and creates `.csv` files of tensorboard plots using `extract_tb_data.py`. Next, they are copied over to be used in plotting.
- `average_all.sh` averages data over runs. Uses `average_data.py` to average over `.csv` files.
