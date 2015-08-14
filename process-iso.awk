#!/usr/bin/env awk

BEGIN {
  FS = "\t"
  url1 = "http://gs.statcounter.com/chart.php?device=Desktop%2C%20Tablet%20%26%20Console&device_hidden=desktop%2Btablet%2Bconsole&statType_hidden=browser&region_hidden="
  url2 = "&granularity=yearly&statType=Browser&region="
  url3 = "&fromInt=2008&toInt=2015&fromYear=2008&toYear=2015&multi-device=true&csv=1"
}

/^A[DEF]/{
  print url1 $1 url2 $2 url3 "," $1 "," $2
}

