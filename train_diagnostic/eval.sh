#!/bin/bash
set -eu

# echo "OLD SOFTMAX seed 1"
# python3 ../../machine/eval_rl.py \
#   --env BabyAI-CustomGoToObjSmall-v0 \
#   --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2494881_19-05-24-12-01-44/007400_check.pt \
#   --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2494881_19-05-24-12-01-44/vocab.json  \
#   --reasoning diagnostic \
#   --seed 1 \
#   --episodes 100 | grep Accuracy;

# echo "OLD SOFTMAX seed 42"
# python3 ../../machine/eval_rl.py \
#   --env BabyAI-CustomGoToObjSmall-v0 \
#   --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed42_job2496877_19-05-26-21-52-00/007400_check.pt \
#   --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed42_job2496877_19-05-26-21-52-00/vocab.json  \
#   --reasoning diagnostic \
#   --seed 1 \
#   --episodes 100 | grep Accuracy;


# echo "LOGSOFTMAX seed 1"
# python3 ../../machine/eval_rl.py \
#   --env BabyAI-CustomGoToObjSmall-v0 \
#   --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2498909_19-05-27-15-32-01/003700_check.pt \
#   --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2498909_19-05-27-15-32-01/vocab.json  \
#   --reasoning model \
#   --seed 42 \
#   --episodes 100;

echo "New 18 seed 1"
# BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2501148_19-05-28-13-09-02
python3 ../../machine/eval_rl.py \
  --env BabyAI-CustomGoToObjSmall-v0 \
  --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2501148_19-05-28-13-09-02/001900_check.pt \
  --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2501148_19-05-28-13-09-02/vocab.json  \
  --reasoning model \
  --episodes 100;



python3 ../../machine/eval_rl.py \
  --env BabyAI-CustomGoToObjSmall-v0 \
  --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed2_job2554084_19-06-11-15-17-21/006600_check.pt \
  --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed2_job2554084_19-06-11-15-17-21/vocab.json  \
  --reasoning model \
  --episodes 100;

python3 ../../machine/eval_rl.py \
  --env BabyAI-CustomGoToObjSmall-v0 \
  --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_AC_expert_filmcnn_gru_mem_seed1_job2300034_19-05-14-18-08-30/007600_check.pt \
  --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_AC_expert_filmcnn_gru_mem_seed1_job2300034_19-05-14-18-08-30/vocab.json \
  --reasoning model \
  --episodes 5000;

python3 ../../machine/eval_rl.py \
  --env BabyAI-CustomGoToObjSmall-v0 \
  --model ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2603358_19-06-26-10-53-26/005600_check.pt \
  --vocab ../../machine/models/BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2603358_19-06-26-10-53-26/vocab.json \
  --reasoning model \
  --episodes 5000;


  BabyAI-CustomGoToObjSmall-v0-_PPO_IAC_expert_filmcnn_gru_mem_seed1_job2594953_19-06-24-10-46-32