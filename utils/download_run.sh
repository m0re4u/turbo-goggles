#! /bin/bash

set -eu -o pipefail

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR

SSH_ARGS="-o LogLevel=error"
LISA_RUNS_PATH="machine/runs/"
LISA_HOSTNAME="lisa.surfsara.nl"

if [ -z "$LISA_USERNAME" ]; then
    echo "LISA username unset"
    exit 1
fi

re='^[0-9]+$'

for var in $@; do
    # Check if input arguments are only numerical (job ids)
    if ! [[ $var =~ $re ]]; then
        echo "$var is not a jobid, skipping.." >&2;
    else
        echo "Pulling job $var"
        DIRNAME=$(ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "ls $LISA_RUNS_PATH/ | grep $var")
        scp -r $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME:$LISA_RUNS_PATH/$DIRNAME ~/projects/uni/thesis/machine/runs/
    fi
done
