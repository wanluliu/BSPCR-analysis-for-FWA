#!/bin/bash
FILES=./*type.txt
         for f in $FILES
         do 
         echo "$f"
         awk '{if ($2>=13038007 && $2 <13038143) print $0}' $f > $f\_region0.txt
         awk '{if ($2>=13038143 && $2 <=13038272) print $0}' $f > $f\_region1.txt
         awk '{if ($2>=13038356 && $2 <=13038499) print $0}' $f > $f\_region2.txt
         awk '{if ($2>=13038568 && $2 <=13038695) print $0}' $f > $f\_region3.txt
         awk '{if ($2>=13034186 && $2 <=13034278) print $0}' $f > $f\_region4.txt
         awk '{if ($2>=13044660 && $2 <=13044759) print $0}' $f > $f\_region5.txt
         done
