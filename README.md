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
GNUplot scripts for visualizing the performance of my models, and a big python plotter to mass create plots from tensorboard progress.

Required packages:
- matplotlib
- numpy

## Train diagnostic
Files for training the diagnostic classifier over the hidden state of the ACModel LSTM. Additional functionality include gathering experience for datasets, examining the output of the trained models and online evaluation in the RL setting, as well as zero-shot and transfer learning experiments.

Also contains evaluation script for the diagnostic classifier for the creation of a confusion matrix.

Required packages:
- torch
- numpy
- machine


## Utils
Some extra utilities:
- `replace_infile.sh` loops over (SLURM output) files and tries to replace some text inside each file.
- `pull_jobs.sh` connects to Lisa, and creates `.csv` files of tensorboard plots using `extract_tb_data.py`. Next, they are copied over to be used in plotting.
- `average_all.sh` averages data over runs. Uses `average_data.py` to average over `.csv` files.
- `download_model.sh` downloads models from Lisa using job ids.
- `download_runs.sh` downloads tensorboard run files from Lisa using job ids.
- `download_logs.sh` downloads log result files generated from jobs running on Lisa.
