#!/bin/bash
set -eu

python3 ../../machine/eval_rl.py \
  --env BabyAI-CustomGoToObjSmall-v0 \
  --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2494881_19-05-24-12-01-44/007400_check.pt \
  --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2494881_19-05-24-12-01-44/vocab.json  \
  --reasoning diagnostic \
  --seed 1 \
  --episodes 100 | grep Accuracy;

python3 ../../machine/eval_rl.py \
  --env BabyAI-CustomGoToObjSmall-v0 \
  --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed42_job2496877_19-05-26-21-52-00/007400_check.pt \
  --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed42_job2496877_19-05-26-21-52-00/vocab.json  \
  --reasoning diagnostic \
  --seed 1 \
  --episodes 100 | grep Accuracy;
