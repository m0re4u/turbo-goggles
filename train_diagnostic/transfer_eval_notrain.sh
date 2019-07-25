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
    transfer_eval 2669860 014000 21 BabyAI-TransferGoToObjBeforeAfter0-v0 base_beforeafter_1_color
    transfer_eval 2669861 014000 21 BabyAI-TransferGoToObjBeforeAfter0-v0 base_beforeafter_42_color
    transfer_eval 2669862 014000 21 BabyAI-TransferGoToObjBeforeAfter0-v0 base_beforeafter_100_color

    transfer_eval 2669860 014000 24 BabyAI-TransferGoToObjBeforeAfter1-v0 base_beforeafter_1_obj
    transfer_eval 2669861 014000 24 BabyAI-TransferGoToObjBeforeAfter1-v0 base_beforeafter_42_obj
    transfer_eval 2669862 014000 24 BabyAI-TransferGoToObjBeforeAfter1-v0 base_beforeafter_100_obj

    transfer_eval 2669860 014000 28 BabyAI-TransferGoToObjBeforeAfter2-v0 base_beforeafter_1_colobj
    transfer_eval 2669861 014000 28 BabyAI-TransferGoToObjBeforeAfter2-v0 base_beforeafter_42_colobj
    transfer_eval 2669862 014000 28 BabyAI-TransferGoToObjBeforeAfter2-v0 base_beforeafter_100_colobj

    transfer_eval 2689034 025000 21 BabyAI-TransferGoToObjBeforeAfter0-v0 new_beforeafter_1_color
    transfer_eval 2689035 025000 21 BabyAI-TransferGoToObjBeforeAfter0-v0 new_beforeafter_42_color
    transfer_eval 2689036 025000 21 BabyAI-TransferGoToObjBeforeAfter0-v0 new_beforeafter_100_color

    transfer_eval 2689034 025000 24 BabyAI-TransferGoToObjBeforeAfter1-v0 new_beforeafter_1_obj
    transfer_eval 2689035 025000 24 BabyAI-TransferGoToObjBeforeAfter1-v0 new_beforeafter_42_obj
    transfer_eval 2689036 025000 24 BabyAI-TransferGoToObjBeforeAfter1-v0 new_beforeafter_100_obj

    transfer_eval 2689034 025000 28 BabyAI-TransferGoToObjBeforeAfter2-v0 new_beforeafter_1_colobj
    transfer_eval 2689035 025000 28 BabyAI-TransferGoToObjBeforeAfter2-v0 new_beforeafter_42_colobj
    transfer_eval 2689036 025000 28 BabyAI-TransferGoToObjBeforeAfter2-v0 new_beforeafter_100_colobj
elif [ "$LEVEL" == "and" ]; then
    # And level
    echo "And"
    transfer_eval 2709216 010000 21 BabyAI-TransferGoToObjAnd0-v0 base_and_1_color
    transfer_eval 2709217 010000 21 BabyAI-TransferGoToObjAnd0-v0 base_and_42_color
    transfer_eval 2709218 010000 21 BabyAI-TransferGoToObjAnd0-v0 base_and_100_color

    transfer_eval 2709216 010000 24 BabyAI-TransferGoToObjAnd1-v0 base_and_1_obj
    transfer_eval 2709217 010000 24 BabyAI-TransferGoToObjAnd1-v0 base_and_42_obj
    transfer_eval 2709218 010000 24 BabyAI-TransferGoToObjAnd1-v0 base_and_100_obj

    transfer_eval 2709216 010000 28 BabyAI-TransferGoToObjAnd2-v0 base_and_1_colobj
    transfer_eval 2709217 010000 28 BabyAI-TransferGoToObjAnd2-v0 base_and_42_colobj
    transfer_eval 2709218 010000 28 BabyAI-TransferGoToObjAnd2-v0 base_and_100_colobj

    transfer_eval 2691623 010100 21 BabyAI-TransferGoToObjAnd0-v0 new_and_1_color
    transfer_eval 2731546 009500 21 BabyAI-TransferGoToObjAnd0-v0 new_and_43_color
    transfer_eval 2691625 010000 21 BabyAI-TransferGoToObjAnd0-v0 new_and_100_color

    transfer_eval 2691623 010100 24 BabyAI-TransferGoToObjAnd1-v0 new_and_1_obj
    transfer_eval 2731546 009500 24 BabyAI-TransferGoToObjAnd1-v0 new_and_43_obj
    transfer_eval 2691625 010000 24 BabyAI-TransferGoToObjAnd1-v0 new_and_100_obj

    transfer_eval 2691623 010100 28 BabyAI-TransferGoToObjAnd2-v0 new_and_1_colobj
    transfer_eval 2731546 009500 28 BabyAI-TransferGoToObjAnd2-v0 new_and_43_colobj
    transfer_eval 2691625 010000 28 BabyAI-TransferGoToObjAnd2-v0 new_and_100_colobj
fi