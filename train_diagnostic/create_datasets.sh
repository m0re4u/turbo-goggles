#! /bin/bash
set -eu

EPISODES="${1:-100}"
MODEL_DIR="../../machine/models/"

function create_datasets {
    # $1 jobid
    # $2 checkno
    # $3 LevelName
    # $4 Dataset dir
    python3 ../../machine/eval_rl.py \
    --env $3 \
    --model ../../machine/models/$(ls $MODEL_DIR | grep $1)/$2_check.pt \
    --vocab ../../machine/models/$(ls $MODEL_DIR | grep $1)/vocab.json \
    --reasoning model \
    --gather \
    --machine \
    --data_dir $4 \
    --episodes $EPISODES >> create_datasets_$EPISODES.log
    sed -i '${s/$/'",$4"'/}' "create_datasets_"$EPISODES".log"
}

rm -f create_datasets_$EPISODES.log
touch create_datasets_$EPISODES.log

# create_datasets 2654515 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed1
# create_datasets 2669640 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed42
# create_datasets 2669641 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed100
# create_datasets 2651250 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed1
# create_datasets 2654157 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed42
# create_datasets 2669857 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed100

# create_datasets 2709216 010000 BabyAI-CustomGoToObjAnd-v0 and_base_seed1
# create_datasets 2709217 010000 BabyAI-CustomGoToObjAnd-v0 and_base_seed42
# create_datasets 2709218 010000 BabyAI-CustomGoToObjAnd-v0 and_base_seed100
# create_datasets 2691623 010000 BabyAI-CustomGoToObjAnd-v0 and_new_seed1
# create_datasets 2731546 009500 BabyAI-CustomGoToObjAnd-v0 and_new_seed43
# create_datasets 2691625 010000 BabyAI-CustomGoToObjAnd-v0 and_new_seed100

# create_datasets 2669860 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed1
# create_datasets 2669861 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed42
# create_datasets 2669862 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed100
# create_datasets 2689034 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed1
# create_datasets 2689035 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed42
# create_datasets 2689036 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed100


create_datasets 2782514 022000 BabyAI-CustomGoToObjSmall-v0 sparsesmall_new_seed1
create_datasets 2782515 022000 BabyAI-CustomGoToObjSmall-v0 sparsesmall_new_seed42
create_datasets 2786348 022000 BabyAI-CustomGoToObjMedium-v0 sparsebeforeafter_new_seed1
create_datasets 2786349 022000 BabyAI-CustomGoToObjMedium-v0 sparsebeforeafter_new_seed42

create_datasets 2787207 014500 BabyAI-CustomGoToObjMultiple-v0 multiple_base_seed1
create_datasets 2787208 014500 BabyAI-CustomGoToObjMultiple-v0 multiple_base_seed42
create_datasets 2787206 014500 BabyAI-CustomGoToObjMultiple-v0 multiple_base_seed100
create_datasets 2787396 016500 BabyAI-CustomGoToObjMultiple-v0 multiple_new_seed1
create_datasets 2787397 016500 BabyAI-CustomGoToObjMultiple-v0 multiple_new_seed42
create_datasets 2787398 014500 BabyAI-CustomGoToObjMultiple-v0 multiple_new_seed100

create_datasets 2787423 011000 BabyAI-CustomGoToObjThrees-v0 threes_base_seed1
create_datasets 2787424 011000 BabyAI-CustomGoToObjThrees-v0 threes_base_seed42
create_datasets 2787422 011000 BabyAI-CustomGoToObjThrees-v0 threes_base_seed100
create_datasets 2787426 013000 BabyAI-CustomGoToObjThrees-v0 threes_new_seed1
create_datasets 2787427 011000 BabyAI-CustomGoToObjThrees-v0 threes_new_seed42
create_datasets 2787425 013000 BabyAI-CustomGoToObjThrees-v0 threes_new_seed100