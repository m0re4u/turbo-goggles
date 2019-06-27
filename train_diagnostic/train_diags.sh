#! /bin/bash
set -eu


DATA_DIR=data/
EPOCHS=10
LR=0.001

function train_diag {
    # $1 seed
    # $2 data_dir
    # $3 outfile
    python3 train_diag.py --seed $1 --lr $LR --epochs $EPOCHS --outfile $3 --data_dir $2
}

for dataset in $DATA_DIR/*; do
    # train with seed 1
    train_diag 1 $dataset/ "$(basename $dataset)"_diagseed1.pt

    # train with seed 2
    train_diag 2 $dataset/ "$(basename $dataset)"_diagseed2.pt

    # train with seed 3
    train_diag 3 $dataset/ "$(basename $dataset)"_diagseed3.pt
done