#! /bin/bash
set -eu

EPISODES="${1:-100}"
MODEL_DIR="../../machine/models/"

function confusion {
    # $1 jobid
    # $2 checkno
    # $3 LevelName
    # $4 Dataset dir
    python3 ../../machine/eval_rl.py \
    --env $3 \
    --model ../../machine/models/$(ls $MODEL_DIR | grep $1)/$2_check.pt \
    --vocab ../../machine/models/$(ls $MODEL_DIR | grep $1)/vocab.json \
    --reasoning model \
    --confusion $4 \
    --episodes $EPISODES
}


confusion 2651250 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed1
confusion 2654157 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed42
confusion 2669857 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed100

confusion 2691623 010000 BabyAI-CustomGoToObjAnd-v0 and_new_seed1
confusion 2731546 009500 BabyAI-CustomGoToObjAnd-v0 and_new_seed43
confusion 2691625 010000 BabyAI-CustomGoToObjAnd-v0 and_new_seed100

confusion 2689034 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed1
confusion 2689035 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed42
confusion 2689036 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed100