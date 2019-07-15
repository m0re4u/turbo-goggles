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

eval_diags_online 2651250 012200 BabyAI-CustomGoToObjSmall-v0 small_new_seed1
# eval_diags_online 2613725 006500 BabyAI-CustomGoToObjSmall-v0 small_new_seed42
# eval_diags_online 2613726 005900 BabyAI-CustomGoToObjSmall-v0 small_new_seed100
# eval_diags_online 2604666 005900 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed1
# eval_diags_online 2607672 005400 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed42
# eval_diags_online 2607673 006200 BabyAI-CustomGoToObjAndOr-v0 andor_new_seed100
# eval_diags_online 2604667 005400 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed1
# eval_diags_online 2607675 005600 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed42
# eval_diags_online 2607674 006500 BabyAI-CustomGoToObjMedium-v0 beforeafter_new_seed100
# eval_diags_online 2300034 007600 BabyAI-CustomGoToObjSmall-v0 small_base_seed1
# eval_diags_online 2489287 007600 BabyAI-CustomGoToObjSmall-v0 small_base_seed42
# eval_diags_online 2607643 007100 BabyAI-CustomGoToObjSmall-v0 small_base_seed100
# eval_diags_online 2604660 003000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed1
# eval_diags_online 2607640 007000 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed42
# eval_diags_online 2607638 007100 BabyAI-CustomGoToObjMedium-v0 beforeafter_base_seed100
# eval_diags_online 2604665 002300 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed1
# eval_diags_online 2607635 006900 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed42
# eval_diags_online 2607636 006800 BabyAI-CustomGoToObjAndOr-v0 andor_base_seed100