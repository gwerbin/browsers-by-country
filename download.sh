#!/usr/bin/env bash

if [[ ! -d data ]]; then mkdir data; fi

for year in 20{08..15}; do
  case "$year" in
    2008) months=$(seq -s ' ' 7 12);;
    2015) months=$(seq -s ' ' 1 7);;
    *) months=$(seq -s ' ' 1 12);;
  esac
  for month in ${months}; do
    echo "Saving data from ${month}, ${year} to data/${month}-${year}.csv"
    # curl -L -o "data/${month}-${year}.csv" "http://gs.statcounter.com/download/browser-country/?year=${year}&month=${month}"
  done
done

