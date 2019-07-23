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
        --episodes $EPISODES >> trained_transfer_eval_"$EPISODES"_$LEVEL.log;
        sed -i '${s/$/'",$5_$i"'/}' "trained_transfer_eval_"$EPISODES"_$LEVEL.log"
    done
}


rm -f trained_transfer_eval_"$EPISODES"_$LEVEL.log
touch trained_transfer_eval_"$EPISODES"_$LEVEL.log


# Small level
if [ $LEVEL == 'small' ]; then
    echo "Small"
    transfer_eval 2695349 000400 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_1_color 2654515
    transfer_eval 2695355 000400 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_1_obj 2654515
    transfer_eval 2695361 000400 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_1_colobj 2654515
    transfer_eval 2695348 000400 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_42_color 2669640
    transfer_eval 2695354 000400 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_42_obj 2669640
    transfer_eval 2695360 000400 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_42_colobj 2669640
    transfer_eval 2695347 000400 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_100_color 2669641
    transfer_eval 2695353 000400 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_100_obj 2669641
    transfer_eval 2695359 000400 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_100_colobj 2669641
    transfer_eval 2699489 000800 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_1_color 2651250
    transfer_eval 2699492 000800 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_1_obj 2651250
    transfer_eval 2699495 000800 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_1_colobj 2651250
    transfer_eval 2699488 000800 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_42_color 2654157
    transfer_eval 2699491 000800 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_42_obj 2654157
    transfer_eval 2699494 000800 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_42_colobj 2654157
    transfer_eval 2699487 000800 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_100_color 2669857
    transfer_eval 2699490 000800 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_100_obj 2669857
    transfer_eval 2699493 000800 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_100_colobj 2669857
elif [ "$LEVEL" == "beforeafter" ]; then
    # Medium level (Beforeafter)
    echo "Beforeafter"
    transfer_eval 2644988 000100 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_base_beforeafter_1_color 2604660
    transfer_eval 2644994 000100 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_base_beforeafter_1_obj 2604660
    transfer_eval 2645000 000100 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_base_beforeafter_1_colobj 2604660
    transfer_eval 2644987 000100 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_base_beforeafter_42_color 2607640
    transfer_eval 2644993 000100 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_base_beforeafter_42_obj 2607640
    transfer_eval 2644999 000100 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_base_beforeafter_42_colobj 2607640
    transfer_eval 2644986 000100 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_base_beforeafter_100_color 2607638
    transfer_eval 2644992 000100 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_base_beforeafter_100_obj 2607638
    transfer_eval 2644998 000100 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_base_beforeafter_100_colobj 2607638
    transfer_eval 2644991 000100 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_new_beforeafter_1_color 2604667
    transfer_eval 2644997 000100 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_new_beforeafter_1_obj 2604667
    transfer_eval 2645003 000100 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_new_beforeafter_1_colobj 2604667
    transfer_eval 2644990 000100 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_new_beforeafter_42_color 2607675
    transfer_eval 2644996 000100 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_new_beforeafter_42_obj 2607675
    transfer_eval 2645002 000100 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_new_beforeafter_42_colobj 2607675
    transfer_eval 2644989 000100 21 BabyAI-TransferGoToObjBeforeAfter0-v0 train_new_beforeafter_100_color 2607674
    transfer_eval 2644995 000100 24 BabyAI-TransferGoToObjBeforeAfter1-v0 train_new_beforeafter_100_obj 2607674
    transfer_eval 2645001 000100 28 BabyAI-TransferGoToObjBeforeAfter2-v0 train_new_beforeafter_100_colobj 2607674
elif [ "$LEVEL" == "and" ]; then
    # And level
    echo "And"
    transfer_eval 2645227 000100 21 BabyAI-TransferGoToObjAnd0-v0 train_base_and_1_color 2709216
    transfer_eval 2645233 000100 24 BabyAI-TransferGoToObjAnd1-v0 train_base_and_1_obj 2709216
    transfer_eval 2645239 000100 28 BabyAI-TransferGoToObjAnd2-v0 train_base_and_1_colobj 2709216
    transfer_eval 2645226 000100 21 BabyAI-TransferGoToObjAnd0-v0 train_base_and_42_color 2709217
    transfer_eval 2645232 000100 24 BabyAI-TransferGoToObjAnd1-v0 train_base_and_42_obj 2709217
    transfer_eval 2645238 000100 28 BabyAI-TransferGoToObjAnd2-v0 train_base_and_42_colobj 2709217
    transfer_eval 2645225 000100 21 BabyAI-TransferGoToObjAnd0-v0 train_base_and_100_color 2709218
    transfer_eval 2645231 000100 24 BabyAI-TransferGoToObjAnd1-v0 train_base_and_100_obj 2709218
    transfer_eval 2645237 000100 28 BabyAI-TransferGoToObjAnd2-v0 train_base_and_100_colobj 2709218
    transfer_eval 2645230 000100 21 BabyAI-TransferGoToObjAnd0-v0 train_new_and_1_color 2691623
    transfer_eval 2645236 000100 24 BabyAI-TransferGoToObjAnd1-v0 train_new_and_1_obj 2691623
    transfer_eval 2645242 000100 28 BabyAI-TransferGoToObjAnd2-v0 train_new_and_1_colobj 2691623
    transfer_eval 2645229 000100 21 BabyAI-TransferGoToObjAnd0-v0 train_new_and_42_color 2691624
    transfer_eval 2645235 000100 24 BabyAI-TransferGoToObjAnd1-v0 train_new_and_42_obj 2691624
    transfer_eval 2645241 000100 28 BabyAI-TransferGoToObjAnd2-v0 train_new_and_42_colobj 2691624
    transfer_eval 2645228 000100 21 BabyAI-TransferGoToObjAnd0-v0 train_new_and_100_color 2691625
    transfer_eval 2645234 000100 24 BabyAI-TransferGoToObjAnd1-v0 train_new_and_100_obj 2691625
    transfer_eval 2645240 000100 28 BabyAI-TransferGoToObjAnd2-v0 train_new_and_100_colobj 2691625
fi