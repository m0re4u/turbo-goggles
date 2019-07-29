#! /bin/bash
read -p "Are you sure? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    rm -rf data/*
    rm -rf diags/*
    rm -rf confusions/*
    rm -f *.log
else
    echo "Did nothing."
fi