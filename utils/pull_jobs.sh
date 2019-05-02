
#!/bin/bash
# Pull run data from LISA for local analysis

# strict on bash errors
set -eu -o pipefail
set -x
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

function pull_job {
    FOLDER=$(ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "ls $LISA_RUNS_PATH | grep $1")
    # TODO? Make sure there's only one folder that we find
    FILE=$(ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "ls $LISA_RUNS_PATH/$FOLDER")
    echo $FILE
    rsync -e "ssh $SSH_ARGS" extract_tb_data.py $LISA_USERNAME@$LISA_HOSTNAME:$LISA_ANALYZER_PATH --update --progress
    rpt=$(ssh $SSH_ARGS $LISA_USERNAME@$LISA_HOSTNAME "python3 $LISA_ANALYZER_PATH/$RUNS_EXTRACTOR")
    echo $rpt

}

if [ -z "$LISA_USERNAME" ]; then
    echo "LISA username unset"
    exit 1
fi

re='^[0-9]+$'
for var in $@; do
    if ! [[ $var =~ $re ]] ; then
        echo "$var is not a jobid, skipping.." >&2;
    else
        echo "Pulling job $var"
        pull_job $var
    fi
done
# # Check if input arguments are only numerical (job ids)