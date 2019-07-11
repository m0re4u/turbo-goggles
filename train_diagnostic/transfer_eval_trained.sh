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
if [ $2 == 'small' ]; then
    echo "Small"
    transfer_eval 2629753 000100 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_1_color 2300034
    transfer_eval 2629756 000100 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_1_obj 2300034
    transfer_eval 2629758 000100 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_1_colobj 2300034
    transfer_eval 2644659 000100 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_42_color 2489287
    transfer_eval 2644661 000100 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_42_obj 2489287
    transfer_eval 2644663 000100 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_42_colobj 2489287
    transfer_eval 2644665 000100 21 BabyAI-TransferGoToObjSmall0-v0 train_base_small_100_color 2607643
    transfer_eval 2644667 000100 24 BabyAI-TransferGoToObjSmall1-v0 train_base_small_100_obj 2607643
    transfer_eval 2644669 000100 28 BabyAI-TransferGoToObjSmall2-v0 train_base_small_100_colobj 2607643
    transfer_eval 2629754 000100 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_1_color 2603358
    transfer_eval 2629789 000100 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_1_obj 2603358
    transfer_eval 2629790 000100 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_1_colobj 2603358
    transfer_eval 2644660 000100 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_42_color 2613725
    transfer_eval 2644662 000100 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_42_obj 2613725
    transfer_eval 2644664 000100 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_42_colobj 2613725
    transfer_eval 2644666 000100 21 BabyAI-TransferGoToObjSmall0-v0 train_new_small_100_color 2613726
    transfer_eval 2644668 000100 24 BabyAI-TransferGoToObjSmall1-v0 train_new_small_100_obj 2613726
    transfer_eval 2644670 000100 28 BabyAI-TransferGoToObjSmall2-v0 train_new_small_100_colobj 2613726
elif [ "$2" == "beforeafter" ]; then
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
elif [ "$2" == "andor" ]; then
    # AndOr level
    echo "andor"
    transfer_eval 2645227 000100 21 BabyAI-TransferGoToObjAndOr0-v0 train_base_andor_1_color 2604665
    transfer_eval 2645233 000100 24 BabyAI-TransferGoToObjAndOr1-v0 train_base_andor_1_obj 2604665
    transfer_eval 2645239 000100 28 BabyAI-TransferGoToObjAndOr2-v0 train_base_andor_1_colobj 2604665
    transfer_eval 2645226 000100 21 BabyAI-TransferGoToObjAndOr0-v0 train_base_andor_42_color 2607635
    transfer_eval 2645232 000100 24 BabyAI-TransferGoToObjAndOr1-v0 train_base_andor_42_obj 2607635
    transfer_eval 2645238 000100 28 BabyAI-TransferGoToObjAndOr2-v0 train_base_andor_42_colobj 2607635
    transfer_eval 2645225 000100 21 BabyAI-TransferGoToObjAndOr0-v0 train_base_andor_100_color 2607636
    transfer_eval 2645231 000100 24 BabyAI-TransferGoToObjAndOr1-v0 train_base_andor_100_obj 2607636
    transfer_eval 2645237 000100 28 BabyAI-TransferGoToObjAndOr2-v0 train_base_andor_100_colobj 2607636
    transfer_eval 2645230 000100 21 BabyAI-TransferGoToObjAndOr0-v0 train_new_andor_1_color 2604666
    transfer_eval 2645236 000100 24 BabyAI-TransferGoToObjAndOr1-v0 train_new_andor_1_obj 2604666
    transfer_eval 2645242 000100 28 BabyAI-TransferGoToObjAndOr2-v0 train_new_andor_1_colobj 2604666
    transfer_eval 2645229 000100 21 BabyAI-TransferGoToObjAndOr0-v0 train_new_andor_42_color 2607672
    transfer_eval 2645235 000100 24 BabyAI-TransferGoToObjAndOr1-v0 train_new_andor_42_obj 2607672
    transfer_eval 2645241 000100 28 BabyAI-TransferGoToObjAndOr2-v0 train_new_andor_42_colobj 2607672
    transfer_eval 2645228 000100 21 BabyAI-TransferGoToObjAndOr0-v0 train_new_andor_100_color 2607673
    transfer_eval 2645234 000100 24 BabyAI-TransferGoToObjAndOr1-v0 train_new_andor_100_obj 2607673
    transfer_eval 2645240 000100 28 BabyAI-TransferGoToObjAndOr2-v0 train_new_andor_100_colobj 2607673
fi