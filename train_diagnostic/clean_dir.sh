#! /bin/bash
read -p "Are you sure? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    rm -rf data/*
    rm -rf diags/*
    rm -f *.log
else
    echo "Did nothing."
fi