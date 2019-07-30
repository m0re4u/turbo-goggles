#! /bin/bash
set -eu

EPISODES="${1:-100}"
LEVEL="${2:-small}"
INVERT="${3:-no}"
BABY_MODEL_DIR="../../machine/models/"

function transfer_eval {
    # $1 jobid
    # $2 checkno
    # $3 diag targets
    # $4 LevelName
    # $5 name
    # $6 vocab job id
    for i in $(seq 1 3);
    do
        python3 ../../machine/eval_rl.py \
        --env $4 \
        --model ../../machine/models/$(ls $BABY_MODEL_DIR | grep $1)/$2_check.pt \
        --vocab ../../machine/models/$(ls $BABY_MODEL_DIR | grep $6)/vocab.json \
        --reasoning model \
        --diag_targets $3 \
        --machine \
        --seed $i \
        --episodes $EPISODES >> trained_transfer_eval_"$EPISODES"_$LEVEL_$INVERT.log;
        sed -i '${s/$/'",$5_$i"'/}' "trained_transfer_eval_"$EPISODES"_$LEVEL_$INVERT.log"
    done
}


rm -f trained_transfer_eval_"$EPISODES"_$LEVEL_$INVERT.log
touch trained_transfer_eval_"$EPISODES"_$LEVEL_$INVERT.log


if [ $INVERT == 'yes' ]; then
    echo "invert"
    if [ "$LEVEL" == "beforeafter" ]; then
        # Medium level (Beforeafter)
        echo "Beforeafter"
        transfer_eval 2766050 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 invtrain_base_beforeafter_1_color 2669860
        transfer_eval 2766053 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 invtrain_base_beforeafter_1_obj 2669860
        transfer_eval 2766056 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 invtrain_base_beforeafter_1_colobj 2669860
        transfer_eval 2766049 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 invtrain_base_beforeafter_42_color 2669861
        transfer_eval 2766052 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 invtrain_base_beforeafter_42_obj 2669861
        transfer_eval 2766055 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 invtrain_base_beforeafter_42_colobj 2669861
        transfer_eval 2766048 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 invtrain_base_beforeafter_100_color 2669862
        transfer_eval 2766051 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 invtrain_base_beforeafter_100_obj 2669862
        transfer_eval 2766054 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 invtrain_base_beforeafter_100_colobj 2669862
        transfer_eval 2766060 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 invtrain_new_beforeafter_1_color 2689034
        transfer_eval 2766063 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 invtrain_new_beforeafter_1_obj 2689034
        transfer_eval 2766066 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 invtrain_new_beforeafter_1_colobj 2689034
        transfer_eval 2766059 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 invtrain_new_beforeafter_42_color 2689035
        transfer_eval 2766062 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 invtrain_new_beforeafter_42_obj 2689035
        transfer_eval 2766065 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 invtrain_new_beforeafter_42_colobj 2689035
        transfer_eval 2766058 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 invtrain_new_beforeafter_100_color 2689036
        transfer_eval 2766061 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 invtrain_new_beforeafter_100_obj 2689036
        transfer_eval 2766064 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 invtrain_new_beforeafter_100_colobj 2689036
    elif [ "$LEVEL" == "and" ]; then
        # And level
        echo "And"
        # TODO change jobids
        transfer_eval 2733953 000400 21 BabyAI-TransferGoToObjAnd0-v0 invtrain_base_and_1_color 2709216
        transfer_eval 2733959 000400 24 BabyAI-TransferGoToObjAnd1-v0 invtrain_base_and_1_obj 2709216
        transfer_eval 2733965 000400 28 BabyAI-TransferGoToObjAnd2-v0 invtrain_base_and_1_colobj 2709216
        transfer_eval 2733952 000400 21 BabyAI-TransferGoToObjAnd0-v0 invtrain_base_and_42_color 2709217
        transfer_eval 2733958 000400 24 BabyAI-TransferGoToObjAnd1-v0 invtrain_base_and_42_obj 2709217
        transfer_eval 2733964 000400 28 BabyAI-TransferGoToObjAnd2-v0 invtrain_base_and_42_colobj 2709217
        transfer_eval 2733951 000400 21 BabyAI-TransferGoToObjAnd0-v0 invtrain_base_and_100_color 2709218
        transfer_eval 2733957 000400 24 BabyAI-TransferGoToObjAnd1-v0 invtrain_base_and_100_obj 2709218
        transfer_eval 2733963 000400 28 BabyAI-TransferGoToObjAnd2-v0 invtrain_base_and_100_colobj 2709218
        transfer_eval 2733956 000400 21 BabyAI-TransferGoToObjAnd0-v0 invtrain_new_and_1_color 2691623
        transfer_eval 2733962 000400 24 BabyAI-TransferGoToObjAnd1-v0 invtrain_new_and_1_obj 2691623
        transfer_eval 2733968 000400 28 BabyAI-TransferGoToObjAnd2-v0 invtrain_new_and_1_colobj 2691623
        transfer_eval 2741742 000400 21 BabyAI-TransferGoToObjAnd0-v0 invtrain_new_and_42_color 2691624
        transfer_eval 2741743 000400 24 BabyAI-TransferGoToObjAnd1-v0 invtrain_new_and_42_obj 2691624
        transfer_eval 2741744 000400 28 BabyAI-TransferGoToObjAnd2-v0 invtrain_new_and_42_colobj 2691624
        transfer_eval 2733954 000400 21 BabyAI-TransferGoToObjAnd0-v0 invtrain_new_and_100_color 2691625
        transfer_eval 2733960 000400 24 BabyAI-TransferGoToObjAnd1-v0 invtrain_new_and_100_obj 2691625
        transfer_eval 2733966 000400 28 BabyAI-TransferGoToObjAnd2-v0 invtrain_new_and_100_colobj 2691625
    elif [ "$LEVEL" == "small" ]; then
        # Small level
        echo "Small"
        # TODO
    fi
else
    echo "no invert"
    # Small level
    if [ $LEVEL == 'small' ]; then
        echo "Small"
        transfer_eval 2695349 000300 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_1_color 2654515
        transfer_eval 2695355 000300 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_1_obj 2654515
        transfer_eval 2695361 000300 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_1_colobj 2654515
        transfer_eval 2695348 000300 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_42_color 2669640
        transfer_eval 2695354 000300 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_42_obj 2669640
        transfer_eval 2695360 000300 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_42_colobj 2669640
        transfer_eval 2695347 000300 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_100_color 2669641
        transfer_eval 2695353 000300 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_100_obj 2669641
        transfer_eval 2695359 000300 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_100_colobj 2669641
        transfer_eval 2699489 000300 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_1_color 2651250
        transfer_eval 2699492 000300 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_1_obj 2651250
        transfer_eval 2699495 000300 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_1_colobj 2651250
        transfer_eval 2699488 000300 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_42_color 2654157
        transfer_eval 2699491 000300 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_42_obj 2654157
        transfer_eval 2699494 000300 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_42_colobj 2654157
        transfer_eval 2699487 000300 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_100_color 2669857
        transfer_eval 2699490 000300 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_100_obj 2669857
        transfer_eval 2699493 000300 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_100_colobj 2669857
    elif [ "$LEVEL" == "beforeafter" ]; then
        # Medium level (Beforeafter)
        echo "Beforeafter"
        transfer_eval 2733351 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_base_beforeafter_1_color 2669860
        transfer_eval 2733357 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_base_beforeafter_1_obj 2669860
        transfer_eval 2733363 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_base_beforeafter_1_colobj 2669860
        transfer_eval 2733350 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_base_beforeafter_42_color 2669861
        transfer_eval 2733356 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_base_beforeafter_42_obj 2669861
        transfer_eval 2733362 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_base_beforeafter_42_colobj 2669861
        transfer_eval 2733349 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_base_beforeafter_100_color 2669862
        transfer_eval 2733355 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_base_beforeafter_100_obj 2669862
        transfer_eval 2733361 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_base_beforeafter_100_colobj 2669862
        transfer_eval 2733944 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_new_beforeafter_1_color 2689034
        transfer_eval 2733947 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_new_beforeafter_1_obj 2689034
        transfer_eval 2733950 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_new_beforeafter_1_colobj 2689034
        transfer_eval 2733943 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_new_beforeafter_42_color 2689035
        transfer_eval 2733946 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_new_beforeafter_42_obj 2689035
        transfer_eval 2733949 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_new_beforeafter_42_colobj 2689035
        transfer_eval 2733942 000400 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_new_beforeafter_100_color 2689036
        transfer_eval 2733945 000400 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_new_beforeafter_100_obj 2689036
        transfer_eval 2733948 000400 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_new_beforeafter_100_colobj 2689036
    elif [ "$LEVEL" == "and" ]; then
        # And level
        echo "And"
        transfer_eval 2733953 000400 21 BabyAI-TransferGoToObjAnd0-v0 train_base_and_1_color 2709216
        transfer_eval 2733959 000400 24 BabyAI-TransferGoToObjAnd1-v0 train_base_and_1_obj 2709216
        transfer_eval 2733965 000400 28 BabyAI-TransferGoToObjAnd2-v0 train_base_and_1_colobj 2709216
        transfer_eval 2733952 000400 21 BabyAI-TransferGoToObjAnd0-v0 train_base_and_42_color 2709217
        transfer_eval 2733958 000400 24 BabyAI-TransferGoToObjAnd1-v0 train_base_and_42_obj 2709217
        transfer_eval 2733964 000400 28 BabyAI-TransferGoToObjAnd2-v0 train_base_and_42_colobj 2709217
        transfer_eval 2733951 000400 21 BabyAI-TransferGoToObjAnd0-v0 train_base_and_100_color 2709218
        transfer_eval 2733957 000400 24 BabyAI-TransferGoToObjAnd1-v0 train_base_and_100_obj 2709218
        transfer_eval 2733963 000400 28 BabyAI-TransferGoToObjAnd2-v0 train_base_and_100_colobj 2709218
        transfer_eval 2733956 000400 21 BabyAI-TransferGoToObjAnd0-v0 train_new_and_1_color 2691623
        transfer_eval 2733962 000400 24 BabyAI-TransferGoToObjAnd1-v0 train_new_and_1_obj 2691623
        transfer_eval 2733968 000400 28 BabyAI-TransferGoToObjAnd2-v0 train_new_and_1_colobj 2691623
        transfer_eval 2741742 000400 21 BabyAI-TransferGoToObjAnd0-v0 train_new_and_42_color 2691624
        transfer_eval 2741743 000400 24 BabyAI-TransferGoToObjAnd1-v0 train_new_and_42_obj 2691624
        transfer_eval 2741744 000400 28 BabyAI-TransferGoToObjAnd2-v0 train_new_and_42_colobj 2691624
        transfer_eval 2733954 000400 21 BabyAI-TransferGoToObjAnd0-v0 train_new_and_100_color 2691625
        transfer_eval 2733960 000400 24 BabyAI-TransferGoToObjAnd1-v0 train_new_and_100_obj 2691625
        transfer_eval 2733966 000400 28 BabyAI-TransferGoToObjAnd2-v0 train_new_and_100_colobj 2691625
    fi
fi