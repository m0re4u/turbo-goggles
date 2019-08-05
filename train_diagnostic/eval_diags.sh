#! /bin/bash
set -eu

EPISODES="${1:-100}"
BABY_MODEL_DIR="../../machine/models/"
DIAG_MODEL_DIR="diags/"

function eval_diags_online {
    # $1 jobid
    # $2 checkno
    # $3 LevelName
    # $4 diag model name
    for i in $(seq 1 3);
    do
        python3 ../../machine/eval_rl.py \
        --env $3 \
        --model ../../machine/models/$(ls $BABY_MODEL_DIR | grep $1)/$2_check.pt \
        --vocab ../../machine/models/$(ls $BABY_MODEL_DIR | grep $1)/vocab.json \
        --reasoning diagnostic \
        --diag_model $DIAG_MODEL_DIR/$4_diagseed$i.pt \
        --machine \
        --seed $i \
        --episodes $EPISODES >> eval_diags_$EPISODES.log;
        sed -i '${s/$/'",$4_$i"'/}' "eval_diags_$EPISODES.log"
    done
}


rm -f eval_diags_$EPISODES.log
touch eval_diags_$EPISODES.log

# eval_diags_online 2654515 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed1
# eval_diags_online 2669640 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed42
# eval_diags_online 2669641 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed100
# eval_diags_online 2651250 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed1
# eval_diags_online 2654157 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed42
# eval_diags_online 2669857 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed100

# eval_diags_online 2709216 010000 BabyAI-CustomGoToObjAnd-v0 and_base_seed1
# eval_diags_online 2709217 010000 BabyAI-CustomGoToObjAnd-v0 and_base_seed42
# eval_diags_online 2709218 010000 BabyAI-CustomGoToObjAnd-v0 and_base_seed100
# eval_diags_online 2691623 010000 BabyAI-CustomGoToObjAnd-v0 and_new_seed1
# eval_diags_online 2731546 009500 BabyAI-CustomGoToObjAnd-v0 and_new_seed43
# eval_diags_online 2691625 010000 BabyAI-CustomGoToObjAnd-v0 and_new_seed100

# eval_diags_online 2669860 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed1
# eval_diags_online 2669861 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed42
# eval_diags_online 2669862 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed100
# eval_diags_online 2689034 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed1
# eval_diags_online 2689035 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed42
# eval_diags_online 2689036 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed100

create_datasets 2782514 026700 BabyAI-CustomGoToObjSmall-v0 sparsesmall_new_seed1
create_datasets 2782515 025900 BabyAI-CustomGoToObjSmall-v0 sparsesmall_new_seed42
create_datasets 2786348 022700 BabyAI-CustomGoToObjMedium-v0 sparsebeforeafter_new_seed1
create_datasets 2786349 022700 BabyAI-CustomGoToObjMedium-v0 sparsebeforeafter_new_seed42

create_datasets 2787207 018500 BabyAI-CustomGoToObjMultiple-v0 multiple_base_seed1
create_datasets 2787208 019800 BabyAI-CustomGoToObjMultiple-v0 multiple_base_seed42
create_datasets 2787206 021000 BabyAI-CustomGoToObjMultiple-v0 multiple_base_seed100
create_datasets 2787396 017000 BabyAI-CustomGoToObjMultiple-v0 multiple_new_seed1
create_datasets 2787397 017100 BabyAI-CustomGoToObjMultiple-v0 multiple_new_seed42
create_datasets 2787398 015000 BabyAI-CustomGoToObjMultiple-v0 multiple_new_seed100

create_datasets 2787423 018800 BabyAI-CustomGoToObjThrees-v0 threes_base_seed1
create_datasets 2787424 017200 BabyAI-CustomGoToObjThrees-v0 threes_base_seed42
create_datasets 2787422 018700 BabyAI-CustomGoToObjThrees-v0 threes_base_seed100
create_datasets 2787426 013600 BabyAI-CustomGoToObjThrees-v0 threes_new_seed1
create_datasets 2787427 011500 BabyAI-CustomGoToObjThrees-v0 threes_new_seed42
create_datasets 2787425 013500 BabyAI-CustomGoToObjThrees-v0 threes_new_seed100