#!/bin/bash


FIND_CMD=$(find $1 -name 'slurm*')
for f in $FIND_CMD;
do
  CONTENT=$(head -60 $f)
  if [[ $CONTENT == *"n_skills"* ]]; then
    echo "$f :SE model! replacing memory usage"
    sed -i 's/no_mem : False/no_mem : True/' $f
  fi
  echo "----"
done