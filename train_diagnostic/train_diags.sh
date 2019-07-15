#! /bin/bash
set -eu

DATA_DIR=data/
DIAG_DIR=diags/
EPOCHS=10
LR=0.001

function train_diag {
    # $1 seed
    # $2 data_dir
    # $3 outfile
    python3 train_diag.py --seed $1 --lr $LR --epochs $EPOCHS --outfile $3 --data_dir $2 --machine >> train_diags_$EPOCHS.log;
}

rm -f train_diags_$EPOCHS.log
touch train_diags_$EPOCHS.log

rm -rf $DIAG_DIR
mkdir -p $DIAG_DIR

for dataset in $DATA_DIR/*; do
    # train with seed 1
    train_diag 1 $dataset/ "$(basename $dataset)"_diagseed1.pt
    mv "$(basename $dataset)"_diagseed1.pt $DIAG_DIR

    # train with seed 2
    train_diag 2 $dataset/ "$(basename $dataset)"_diagseed2.pt
    mv "$(basename $dataset)"_diagseed2.pt $DIAG_DIR

    # train with seed 3
    train_diag 3 $dataset/ "$(basename $dataset)"_diagseed3.pt
    mv "$(basename $dataset)"_diagseed3.pt $DIAG_DIR

done
