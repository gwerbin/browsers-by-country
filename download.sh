#!/usr/bin/env bash

while IFS=$'\t' read iso country; do
  country=$(echo $country | sed 's/ /%20/g')
  file="${iso}-${country}.csv"
  url='http://gs.statcounter.com/chart.php?device=Desktop%2C%20Tablet%20%26%20Console&device_hidden=desktop%2Btablet%2Bconsole&statType_hidden=browser&region_hidden='${iso}'&granularity=yearly&statType=Browser&region='${country}'&fromInt=2008&toInt=2015&fromYear=2008&toYear=2015&multi-device=true&csv=1'
  echo $url
  # if [[ ! -f $file ]]; then
  #   echo "${country}: saving to ${file}" 
  #   # curl -o $file $url
  # fi
  # if [[ -f $file && -z $(head -n 1 $file | grep 'Country') ]]; then
  #   sed -i ".bak" "1! s/^/${iso},/;1 s/^/\"Country\",/" $file
  #   rm ${file}.bak
  # fi
done < <(head iso2.txt)

