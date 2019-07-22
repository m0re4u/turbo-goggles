#! /bin/bash

set -eu -o pipefail

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR

SSH_ARGS="-o LogLevel=error"
LISA_MODEL_PATH="machine/models/"
LISA_HOSTNAME="lisa.surfsara.nl"

if [ -z "$LISA_USERNAME" ]; then
    echo "LISA username unset"
    exit 1
fi

re='^[0-9]+$'
re_check='^0[0-9]+$'
CHECK_ID=


for var in $@; do
    # Check if input arguments are only numerical (job ids)
    if [[ $var =~ $re_check ]]; then
        # Job id will never start with a zero, so if it does, assume we are given a
        # checkpoint number to pull.
        echo "Set checkpoint number to $var" >&2;
        CHECK_ID="$var"
    elif ! [[ $var =~ $re ]]; then
        echo "$var is not a jobid, skipping.." >&2;
    else
        echo "Pulling model from: $var"
        DIRNAME=$(ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "ls $LISA_MODEL_PATH/ | grep $var")

        # What checkpoint does need to be copied
        if [ ! -z $CHECK_ID ]; then
            CHECKPT="$CHECK_ID"_check.pt
            FILES=(vocab.json $CHECKPT)
        else
            FILES=$(ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "ls $LISA_MODEL_PATH/$DIRNAME -t | head -2")
        fi

        mkdir -p ~/projects/uni/thesis/machine/models/$DIRNAME
        for f in ${FILES[*]}; do
            scp $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_MODEL_PATH/$DIRNAME/$f ~/projects/uni/thesis/machine/models/$DIRNAME/$f
        done
    fi
done
