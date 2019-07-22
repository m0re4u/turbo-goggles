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

create_datasets 2654515 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed1
create_datasets 2669640 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed42
create_datasets 2669641 010000 BabyAI-CustomGoToObjSmall-v0 small_base_seed100
create_datasets 2651250 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed1
create_datasets 2654157 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed42
create_datasets 2669857 010800 BabyAI-CustomGoToObjSmall-v0 small_new_seed100

# create_datasets 2604666 005900 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed1
# create_datasets 2607672 005400 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed42
# create_datasets 2607673 006200 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed100
# create_datasets 2604665 002300 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed1
# create_datasets 2607635 006900 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed42
# create_datasets 2607636 006800 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed100

create_datasets 2669860 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed1
create_datasets 2669861 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed42
create_datasets 2669862 014000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed100
create_datasets 2689034 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed1
create_datasets 2689035 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed42
create_datasets 2689036 025000 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed100