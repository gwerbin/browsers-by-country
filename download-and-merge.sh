#!/usr/bin/env bash

if [[ ! -d data ]]; then mkdir data; fi

for year in $(seq -s ' ' 2008 2015); do
  case "$year" in
    2008) months=$(seq -s ' ' 7 12);;
    2015) months=$(seq -s ' ' 1 7);;
    *) months=$(seq -s ' ' 1 12);;
  esac
  for month in ${months}; do
    filebase="data/${year}-$(printf '%02d' ${month})"
    file="${filebase}.csv"
    file_with_date="${filebase}-withdate.csv"
    if [[ ! -f $file ]]; then
      echo "Downloading data from ${month}/${year}, and saving to ${file}"
      curl -L -m 10 -o $file "http://gs.statcounter.com/download/browser-country/?year=${year}&month=${month}"
    fi
    echo "Appending year and month columns, and saving to ${file_with_date}"
    sed "1s/^/\"Year\",\"Month\",/;1!s/^/${year},${month},/" < $file >| $file_with_date
  done
done

cat data/*-withdate.csv | sed '1!{/^"Year"/d;}' >| data/browsers.csv

