set -eu
IDS="
2818253
2818254
2818255
2812454
2812455
2812456
2818257
2818258
2818260
2812451
2812453
2812452"
SSH_ARGS="-o LogLevel=error"

for id in $IDS; do
    echo -n "$id "
    # DIR=$(ls models/ | grep $id)
    DIR=$(ssh $SSH_ARGS mvdmeer@lisa.surfsara.nl "ls machine/models/ | grep $id")
    # echo $DIR
    ssh $SSH_ARGS mvdmeer@lisa.surfsara.nl "ls machine/models/$DIR -t | head -2 | grep check"
done