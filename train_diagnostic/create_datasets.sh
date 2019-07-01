#! /bin/bash
set -eu

EPISODES="${1:-100}"
MODEL_DIR="../../machine/models/"

function run_datagather {
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
    --episodes $EPISODES > output.log
    ACC=$(cat output.log | grep Accuracy)
    echo "$1_$2_$3 $4  | $ACC " >> final_results_$EPISODES.log
    cp -r data/reason_dataset data/$4
}

rm -f final_results_$EPISODES.log
touch final_results_$EPISODES.log

run_datagather 2603358 005600 BabyAI-CustomGoToObjSmall-v0 small_new_seed1
run_datagather 2613725 006500 BabyAI-CustomGoToObjSmall-v0 small_new_seed42
run_datagather 2613726 005900 BabyAI-CustomGoToObjSmall-v0 small_new_seed100
run_datagather 2604666 005900 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed1
run_datagather 2607672 005400 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed42
run_datagather 2607673 006200 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed100
run_datagather 2604667 005400 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed1
run_datagather 2607675 005600 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed42
run_datagather 2607674 006500 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed100
run_datagather 2300034 007600 BabyAI-CustomGoToObjSmall-v0 small_base_seed1
run_datagather 2489287 007600 BabyAI-CustomGoToObjSmall-v0 small_base_seed42
run_datagather 2607643 007100 BabyAI-CustomGoToObjSmall-v0 small_base_seed100
run_datagather 2604660 003000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed1
run_datagather 2607640 007000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed42
run_datagather 2607638 007100 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed100
run_datagather 2604665 002300 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed1
run_datagather 2607635 006900 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed42
run_datagather 2607636 006800 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed100