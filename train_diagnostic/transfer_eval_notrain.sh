#! /bin/bash
set -eu

EPISODES="${1:-100}"
LEVEL="${2:-small}"
BABY_MODEL_DIR="../../machine/models/"

function transfer_eval {
    # $1 jobid
    # $2 checkno
    # $3 diag targets
    # $4 LevelName
    # $5 name
    for i in $(seq 1 3);
    do
        python3 ../../machine/eval_rl.py \
        --env $4 \
        --model ../../machine/models/$(ls $BABY_MODEL_DIR | grep $1)/$2_check.pt \
        --vocab ../../machine/models/$(ls $BABY_MODEL_DIR | grep $1)/vocab.json \
        --reasoning diagnostic \
        --diag_targets $3 \
        --machine \
        --drop_diag \
        --seed $i \
        --episodes $EPISODES >> transfer_eval_"$EPISODES"_$LEVEL.log;
        sed -i '${s/$/'",$5_$i"'/}' "transfer_eval_"$EPISODES"_$LEVEL.log"
    done
}


rm -f transfer_eval_"$EPISODES"_$LEVEL.log
touch transfer_eval_"$EPISODES"_$LEVEL.log


# Small level
if [ "$LEVEL" == 'small' ]; then
    echo "Small"
    transfer_eval 2654515 010000 21 BabyAI-TransferGoToObjSmall0-v0 base_small_1_color
    transfer_eval 2669640 010000 21 BabyAI-TransferGoToObjSmall0-v0 base_small_42_color
    transfer_eval 2669641 010000 21 BabyAI-TransferGoToObjSmall0-v0 base_small_100_color

    transfer_eval 2654515 010000 24 BabyAI-TransferGoToObjSmall1-v0 base_small_1_obj
    transfer_eval 2669640 010000 24 BabyAI-TransferGoToObjSmall1-v0 base_small_42_obj
    transfer_eval 2669641 010000 24 BabyAI-TransferGoToObjSmall1-v0 base_small_100_obj

    transfer_eval 2654515 010000 28 BabyAI-TransferGoToObjSmall2-v0 base_small_1_colobj
    transfer_eval 2669640 010000 28 BabyAI-TransferGoToObjSmall2-v0 base_small_42_colobj
    transfer_eval 2669641 010000 28 BabyAI-TransferGoToObjSmall2-v0 base_small_100_colobj

    transfer_eval 2651250 010800 21 BabyAI-TransferGoToObjSmall0-v0 new_small_1_color
    transfer_eval 2654157 010800 21 BabyAI-TransferGoToObjSmall0-v0 new_small_42_color
    transfer_eval 2669857 010800 21 BabyAI-TransferGoToObjSmall0-v0 new_small_100_color

    transfer_eval 2651250 010800 24 BabyAI-TransferGoToObjSmall1-v0 new_small_1_obj
    transfer_eval 2654157 010800 24 BabyAI-TransferGoToObjSmall1-v0 new_small_42_obj
    transfer_eval 2669857 010800 24 BabyAI-TransferGoToObjSmall1-v0 new_small_100_obj

    transfer_eval 2651250 010800 28 BabyAI-TransferGoToObjSmall2-v0 new_small_1_colobj
    transfer_eval 2654157 010800 28 BabyAI-TransferGoToObjSmall2-v0 new_small_42_colobj
    transfer_eval 2669857 010800 28 BabyAI-TransferGoToObjSmall2-v0 new_small_100_colobj
elif [ "$LEVEL" == "beforeafter" ]; then
    # Medium level (Beforeafter)
    echo "Beforeafter"
    transfer_eval 2604660 003000 21 BabyAI-TransferGoToObjBeforeAfter0-v0 base_beforeafter_1_color
    transfer_eval 2607640 007000 21 BabyAI-TransferGoToObjBeforeAfter0-v0 base_beforeafter_42_color
    transfer_eval 2607638 007100 21 BabyAI-TransferGoToObjBeforeAfter0-v0 base_beforeafter_100_color

    transfer_eval 2604660 003000 24 BabyAI-TransferGoToObjBeforeAfter1-v0 base_beforeafter_1_obj
    transfer_eval 2607640 007000 24 BabyAI-TransferGoToObjBeforeAfter1-v0 base_beforeafter_42_obj
    transfer_eval 2607638 007100 24 BabyAI-TransferGoToObjBeforeAfter1-v0 base_beforeafter_100_obj

    transfer_eval 2604660 003000 28 BabyAI-TransferGoToObjBeforeAfter2-v0 base_beforeafter_1_colobj
    transfer_eval 2607640 007000 28 BabyAI-TransferGoToObjBeforeAfter2-v0 base_beforeafter_42_colobj
    transfer_eval 2607638 007100 28 BabyAI-TransferGoToObjBeforeAfter2-v0 base_beforeafter_100_colobj

    transfer_eval 2604667 005400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 new_beforeafter_1_color
    transfer_eval 2607675 005600 21 BabyAI-TransferGoToObjBeforeAfter0-v0 new_beforeafter_42_color
    transfer_eval 2607674 006500 21 BabyAI-TransferGoToObjBeforeAfter0-v0 new_beforeafter_100_color

    transfer_eval 2604667 005400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 new_beforeafter_1_obj
    transfer_eval 2607675 005600 24 BabyAI-TransferGoToObjBeforeAfter1-v0 new_beforeafter_42_obj
    transfer_eval 2607674 006500 24 BabyAI-TransferGoToObjBeforeAfter1-v0 new_beforeafter_100_obj

    transfer_eval 2604667 005400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 new_beforeafter_1_colobj
    transfer_eval 2607675 005600 28 BabyAI-TransferGoToObjBeforeAfter2-v0 new_beforeafter_42_colobj
    transfer_eval 2607674 006500 28 BabyAI-TransferGoToObjBeforeAfter2-v0 new_beforeafter_100_colobj
elif [ "$LEVEL" == "andor" ]; then
    # AndOr level
    echo "andor"
    transfer_eval 2604665 002300 21 BabyAI-TransferGoToObjAndOr0-v0 base_andor_1_color
    transfer_eval 2607635 006900 21 BabyAI-TransferGoToObjAndOr0-v0 base_andor_42_color
    transfer_eval 2607636 006800 21 BabyAI-TransferGoToObjAndOr0-v0 base_andor_100_color

    transfer_eval 2604665 002300 24 BabyAI-TransferGoToObjAndOr1-v0 base_andor_1_obj
    transfer_eval 2607635 006900 24 BabyAI-TransferGoToObjAndOr1-v0 base_andor_42_obj
    transfer_eval 2607636 006800 24 BabyAI-TransferGoToObjAndOr1-v0 base_andor_100_obj

    transfer_eval 2604665 002300 28 BabyAI-TransferGoToObjAndOr2-v0 base_andor_1_colobj
    transfer_eval 2607635 006900 28 BabyAI-TransferGoToObjAndOr2-v0 base_andor_42_colobj
    transfer_eval 2607636 006800 28 BabyAI-TransferGoToObjAndOr2-v0 base_andor_100_colobj

    transfer_eval 2604666 005900 21 BabyAI-TransferGoToObjAndOr0-v0 new_andor_1_color
    transfer_eval 2607672 005400 21 BabyAI-TransferGoToObjAndOr0-v0 new_andor_42_color
    transfer_eval 2607673 006200 21 BabyAI-TransferGoToObjAndOr0-v0 new_andor_100_color

    transfer_eval 2604666 005900 24 BabyAI-TransferGoToObjAndOr1-v0 new_andor_1_obj
    transfer_eval 2607672 005400 24 BabyAI-TransferGoToObjAndOr1-v0 new_andor_42_obj
    transfer_eval 2607673 006200 24 BabyAI-TransferGoToObjAndOr1-v0 new_andor_100_obj

    transfer_eval 2604666 005900 28 BabyAI-TransferGoToObjAndOr2-v0 new_andor_1_colobj
    transfer_eval 2607672 005400 28 BabyAI-TransferGoToObjAndOr2-v0 new_andor_42_colobj
    transfer_eval 2607673 006200 28 BabyAI-TransferGoToObjAndOr2-v0 new_andor_100_colobj
fi