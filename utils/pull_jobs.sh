#!/bin/bash -l
# Pull run data from LISA for local analysis

# strict on bash errors
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
LISA_ANALYZER_PATH="run_analyzer/"
RUNS_EXTRACTOR="extract_tb_data.py"
LISA_AGG_PATH="agg"

function execute_agg {
        ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "source /hpc/eb/modules/init/bash;
                                           export -f module;
                                           module load Python/3.6.3-foss-2017b;
                                           python3 $LISA_ANALYZER_PATH/$RUNS_EXTRACTOR $1 $2"
}

function pull_job {
    FOLDER=$(ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "ls $LISA_RUNS_PATH | grep $1")
    # TODO? Make sure there's only one folder that we find
    FILE=$(ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "ls $LISA_RUNS_PATH/$FOLDER")
    # echo $FILE
    rsync -e "ssh $SSH_ARGS" extract_tb_data.py $LISA_USERNAME@$LISA_HOSTNAME:$LISA_ANALYZER_PATH --update --progress
    OUT_PREFIX="agg_$1"
    execute_agg $LISA_RUNS_PATH/$FOLDER/$FILE $LISA_AGG_PATH/$OUT_PREFIX
    rsync -e "ssh $SSH_ARGS" $LISA_USERNAME@$LISA_HOSTNAME:$LISA_AGG_PATH/$OUT_PREFIX* data/
}

if [ -z "$LISA_USERNAME" ]; then
    echo "LISA username unset"
    exit 1
fi

re='^[0-9]+$'

if ! [[ $* == *--plot* ]]; then
    rm -f data/*
    for var in $@; do
        # Check if input arguments are only numerical (job ids)
        if ! [[ $var =~ $re ]]; then
            echo "$var is not a jobid, skipping.." >&2;
        else
            echo "Pulling job $var"
            pull_job $var
            job_arr+=($var)
        fi
    done
else
    for var in $@; do
        if [[ $var =~ $re ]]; then
            job_arr+=($var)
        fi
    done
fi
