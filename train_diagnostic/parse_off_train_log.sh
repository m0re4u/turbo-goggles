#! /bin/bash
set -e
TMPDATAFILE=../plotting/off_curve_data.tmp
DATAFILE=../plotting/off_curve_data.txt
EPOCHS=15

rm -f train_diag.log
rm -f $TMPDATAFILE
rm -f $DATAFILE
touch $TMPDATAFILE

python3 train_diag.py --seed 1 --lr 0.001 --epochs $EPOCHS --outfile test.pt --data_dir data/small_base_seed1/
cat train_diag.log | grep Epoch | awk '{ printf "%f,", $15 }' >> $TMPDATAFILE
echo "" >>  $TMPDATAFILE
cat train_diag.log | grep Epoch | awk '{ printf "%f,", $18 }' >> $TMPDATAFILE
rm train_diag.log

python3 train_diag.py --seed 1 --lr 0.001 --epochs $EPOCHS --outfile test.pt --data_dir data/small_new_seed1/
echo "" >>  $TMPDATAFILE
cat train_diag.log | grep Epoch | awk '{ printf "%f,", $15 }' >> $TMPDATAFILE
echo "" >>  $TMPDATAFILE
cat train_diag.log | grep Epoch | awk '{ printf "%f,", $18 }' >> $TMPDATAFILE
rm train_diag.log

cat $TMPDATAFILE | sed 's/,*$//g' > $DATAFILE
rm $TMPDATAFILE