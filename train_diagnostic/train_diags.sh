#! /bin/bash
set -eu

function train_diag {
    # $1 jobid
    # $2 checkno
    # $3 LevelName
    python3 ../../machine/eval_rl.py \
    --env $3 \
    --model ../../machine/models/$(ls $MODEL_DIR | grep $1)/$2_check.pt \
    --vocab ../../machine/models/$(ls $MODEL_DIR | grep $1)/vocab.json \
    --reasoning model \
    --episodes $EPISODES;

}

run_datagather 2603358 005600 BabyAI-CustomGoToObjSmall-v0
cp -r data/reason_dataset data/small_new_seed1
run_datagather 2604666 005900 BabyAI-CustomGoToObjAndOr-v0
cp -r data/reason_dataset data/andor_new_seed1
run_datagather 2604667 005400 BabyAI-CustomGoToObjMedium-v0
cp -r data/reason_dataset data/beforeafter_new_seed1
run_datagather 2300034 007600 BabyAI-CustomGoToObjSmall-v0
cp -r data/reason_dataset data/small_base_seed1
run_datagather 2489287 007600 BabyAI-CustomGoToObjSmall-v0
cp -r data/reason_dataset data/small_base_seed42
run_datagather 2604660 003000 BabyAI-CustomGoToObjMedium-v0
cp -r data/reason_dataset data/beforeafter_base_seed1
run_datagather 2604665 002300 BabyAI-CustomGoToObjAndOr-v0
cp -r data/reason_dataset data/andor_base_seed1