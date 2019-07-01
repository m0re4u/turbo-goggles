#! /bin/bash
set -eu

EPISODES="${1:-100}"
BABY_MODEL_DIR="../../machine/models/"
DIAG_MODEL_DIR="diags/"

function eval_diag_online {
    # $1 jobid
    # $2 checkno
    # $3 LevelName
    # $4 diag model name
    python3 ../../machine/eval_rl.py \
    --env $3 \
    --model ../../machine/models/$(ls $BABY_MODEL_DIR | grep $1)/$2_check.pt \
    --vocab ../../machine/models/$(ls $BABY_MODEL_DIR | grep $1)/vocab.json \
    --reasoning diagnostic \
    --diag_model $DIAG_MODEL_DIR/$4
    --episodes $EPISODES > output.log
    # ACC=$(cat output.log | grep Accuracy)
    # echo "$1_$2_$3 $4  | $ACC " >> final_results_$EPISODES.log
    # cp -r data/reason_dataset data/$4
}


rm -f eval_diag_$EPISODES.log
touch eval_diag_$EPISODES.log

eval_diag_online 2603358 005600 BabyAI-CustomGoToObjSmall-v0 small_new_seed1_diagseed1.pt
