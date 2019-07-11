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
