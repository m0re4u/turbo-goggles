#! /bin/bash

set -eu -o pipefail

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR

SSH_ARGS="-o LogLevel=error"
LISA_LOGS_PATH="turbo-goggles/train_diagnostic/"
LISA_HOSTNAME="lisa.surfsara.nl"

if [ -z "$LISA_USERNAME" ]; then
    echo "LISA username unset"
    exit 1
fi

# scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_LOGS_PATH/create_datasets_100.log lisa_create_datasets_100.log
# scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_LOGS_PATH/train_diags_10.log lisa_train_diags_10.log
# scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_LOGS_PATH/eval_diags_100.log lisa_eval_diags_100.log
# scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_LOGS_PATH/transfer_eval_100_small.log lisa_transfer_eval_100_small.log
# scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_LOGS_PATH/transfer_eval_100_and.log lisa_transfer_eval_100_and.log
# scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_LOGS_PATH/transfer_eval_100_beforeafter.log lisa_transfer_eval_100_beforeafter.log

FILES="create_datasets_100.log
train_diags_10.log
eval_diags_100.log
transfer_eval_100_small.log
transfer_eval_100_and.log
transfer_eval_100_beforeafter.log
trained_transfer_eval_100_small.log
trained_transfer_eval_100_beforeafter.log
trained_transfer_eval_100_and.log"

for f in $FILES; do
    scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_LOGS_PATH/$f lisa_$f
    sed -i '/no display found. Using non-interactive Agg backend/d' lisa_$f
done