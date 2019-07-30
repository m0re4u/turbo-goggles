#!/bin/bash

# Transfer experiments
python3 average_data.py 2629753 2644659 2644665 --outfile "base small 0"
python3 average_data.py 2629753 2644659 2644665 --outfile "base small 0" --sr

python3 average_data.py 2629756 2644661 2644667 --outfile "base small 1"
python3 average_data.py 2629756 2644661 2644667 --outfile "base small 1" --sr

python3 average_data.py 2629758 2644663 2644669 --outfile "base small 2"
python3 average_data.py 2629758 2644663 2644669 --outfile "base small 2" --sr

python3 average_data.py 2629754 2644660 2644666 --outfile "new small 0"
python3 average_data.py 2629754 2644660 2644666 --outfile "new small 0" --sr

python3 average_data.py 2629789 2644662 2644668 --outfile "new small 1"
python3 average_data.py 2629789 2644662 2644668 --outfile "new small 1" --sr

python3 average_data.py 2629790 2644664 2644670 --outfile "new small 2"
python3 average_data.py 2629790 2644664 2644670 --outfile "new small 2" --sr

python3 average_data.py 2644988 2644987 2644986 --outfile "base beforeafter 0"
python3 average_data.py 2644988 2644987 2644986 --outfile "base beforeafter 0" --sr

python3 average_data.py 2644994 2644993 2644992 --outfile "base beforeafter 1"
python3 average_data.py 2644994 2644993 2644992 --outfile "base beforeafter 1" --sr

python3 average_data.py 2645000 2644999 2644998 --outfile "base beforeafter 2"
python3 average_data.py 2645000 2644999 2644998 --outfile "base beforeafter 2" --sr

python3 average_data.py 2644991 2644990 2644989 --outfile "new beforeafter 0"
python3 average_data.py 2644991 2644990 2644989 --outfile "new beforeafter 0" --sr

python3 average_data.py 2644997 2644996 2644995 --outfile "new beforeafter 1"
python3 average_data.py 2644997 2644996 2644995 --outfile "new beforeafter 1" --sr

python3 average_data.py 2645003 2645002 2645001 --outfile "new beforeafter 2"
python3 average_data.py 2645003 2645002 2645001 --outfile "new beforeafter 2" --sr

python3 average_data.py 2645227 2645226 2645225 --outfile "base andor 0"
python3 average_data.py 2645227 2645226 2645225 --outfile "base andor 0" --sr

python3 average_data.py 2645233 2645232 2645231 --outfile "base andor 1"
python3 average_data.py 2645233 2645232 2645231 --outfile "base andor 1" --sr

python3 average_data.py 2645239 2645238 2645237 --outfile "base andor 2"
python3 average_data.py 2645239 2645238 2645237 --outfile "base andor 2" --sr

python3 average_data.py 2645230 2645229 2645228 --outfile "new andor 0"
python3 average_data.py 2645230 2645229 2645228 --outfile "new andor 0" --sr

python3 average_data.py 2645236 2645235 2645234 --outfile "new andor 1"
python3 average_data.py 2645236 2645235 2645234 --outfile "new andor 1" --sr

python3 average_data.py 2645242 2645241 2645240 --outfile "new andor 2"
python3 average_data.py 2645242 2645241 2645240 --outfile "new andor 2" --sr

# Trained transfer BeforeAfter (BA)
python3 average_data.py 2733351 2733350 2733349 --outfile "BA 0 no base"
python3 average_data.py 2733351 2733350 2733349 --outfile "BA 0 no base" --sr
python3 average_data.py 2733357 2733356 2733355 --outfile "BA 1 no base"
python3 average_data.py 2733357 2733356 2733355 --outfile "BA 1 no base" --sr
python3 average_data.py 2733363 2733362 2733361 --outfile "BA 2 no base"
python3 average_data.py 2733363 2733362 2733361 --outfile "BA 2 no base" --sr

python3 average_data.py 2766050 2766049 2766048 --outfile "BA 0 yes base"
python3 average_data.py 2766050 2766049 2766048 --outfile "BA 0 yes base" --sr
python3 average_data.py 2766053 2766052 2766051 --outfile "BA 1 yes base"
python3 average_data.py 2766053 2766052 2766051 --outfile "BA 1 yes base" --sr
python3 average_data.py 2766056 2766055 2766054 --outfile "BA 2 yes base"
python3 average_data.py 2766056 2766055 2766054 --outfile "BA 2 yes base" --sr

python3 average_data.py 2733944 2733943 2733942 --outfile "BA 0 no new"
python3 average_data.py 2733944 2733943 2733942 --outfile "BA 0 no new" --sr
python3 average_data.py 2733947 2733946 2733945 --outfile "BA 1 no new"
python3 average_data.py 2733947 2733946 2733945 --outfile "BA 1 no new" --sr
python3 average_data.py 2733950 2733949 2733948 --outfile "BA 2 no new"
python3 average_data.py 2733950 2733949 2733948 --outfile "BA 2 no new" --sr

python3 average_data.py 2766060 2766059 2766058 --outfile "BA 0 yes new"
python3 average_data.py 2766060 2766059 2766058 --outfile "BA 0 yes new" --sr
python3 average_data.py 2766063 2766062 2766061 --outfile "BA 1 yes new"
python3 average_data.py 2766063 2766062 2766061 --outfile "BA 1 yes new" --sr
python3 average_data.py 2766066 2766065 2766064 --outfile "BA 2 yes new"
python3 average_data.py 2766066 2766065 2766064 --outfile "BA 2 yes new" --sr
