#!/bin/bash

python3 average_data.py 2247234 2265470 --level PutNextLocal --segment_level word --sr
python3 average_data.py 2247234 2265470 --level PutNextLocal --segment_level word

python3 average_data.py 2268404 2266463 --level PutNextLocal --segment_level wordannotated --sr
python3 average_data.py 2268404 2266463 --level PutNextLocal --segment_level wordannotated

python3 average_data.py 2268403 2266462 --level PutNextLocal --segment_level segment --sr
python3 average_data.py 2268403 2266462 --level PutNextLocal --segment_level segment

python3 average_data.py 2247231 2265467 --level PickupLoc --segment_level word --sr
python3 average_data.py 2247231 2265467 --level PickupLoc --segment_level word

python3 average_data.py 2268401 2266708 --level PickupLoc --segment_level wordannotated --sr
python3 average_data.py 2268401 2266708 --level PickupLoc --segment_level wordannotated

python3 average_data.py 2268402 2266709 --level PickupLoc --segment_level segment --sr
python3 average_data.py 2268402 2266709 --level PickupLoc --segment_level segment

python3 average_data.py 2247228 2265464 --level GoTo --segment_level word --sr
python3 average_data.py 2247228 2265464 --level GoTo --segment_level word

python3 average_data.py 2268406 2266710 --level GoTo --segment_level wordannotated --sr
python3 average_data.py 2268406 2266710 --level GoTo --segment_level wordannotated

python3 average_data.py 2268405 2266711 --level GoTo --segment_level segment --sr
python3 average_data.py 2268405 2266711 --level GoTo --segment_level segment
