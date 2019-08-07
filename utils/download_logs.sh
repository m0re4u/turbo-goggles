#! /bin/bash

set -eu

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR

SSH_ARGS="-o LogLevel=error -q"
LISA_LOGS_PATH="turbo-goggles/train_diagnostic/"
LISA_HOSTNAME="lisa.surfsara.nl"

if [ -z "$LISA_USERNAME" ]; then
    echo "LISA username unset"
    exit 1
fi

FILES="create_datasets_100.log
train_diags_10.log
eval_diags_100.log
transfer_eval_100_small.log
transfer_eval_100_and.log
transfer_eval_100_beforeafter.log
trained_transfer_eval_100_small.log
trained_transfer_eval_100_beforeafter.log
trained_transfer_eval_100_and.log
transfer_eval_100_sparse.log
transfer_eval_100_multiple.log
transfer_eval_100_threes.log"

for f in $FILES; do

    if ssh -q $LISA_USERNAME@$LISA_HOSTNAME [[ -f $LISA_LOGS_PATH/$f ]]; then
        scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_LOGS_PATH/$f lisa_$f
        sed -i '/no display found. Using non-interactive Agg backend/d' lisa_$f
    else
        echo Missing $f on remote, skipping..
    fi
done