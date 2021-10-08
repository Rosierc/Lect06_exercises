#!/usr/bin/awk -f
BEGIN {
count_shortmismatch = 0
count_shorthsp = 0
count_tophsp = 0
n = 0
}

{
if (substr($1,1,3)=="NC_")
 {
 print $2 > "listacc.csv";
 print $4 > "listlen.csv";
 print $3 > "percentid.csv";
 if ($5 > 20)
  {
  print $2 > "mismatch.csv";
  if ($4 < 100)
   {
   print $2 > "mismatch&short.csv"
   }
  }
 if ($5 < 20)
  {
  count_shortmismatch ++
  if (count_shortmismatch <= 20)
   {
   print $2 > "top20mismatch.csv"
   }
  }
 if ($4 < 100)
  {
  count_shorthsp ++
  }
 if (count_tophsp <= 10)
  {
  count_tophsp ++
  print $2 > "top10hsp.csv"
  }
 }
 n = len($2)
 if (substr($2,1:n-3,3) == "AEI")
  {
  print $7 > "startposAEI.csv"
  }
}

END {
print count_shorthsp > "summary.txt"
}
