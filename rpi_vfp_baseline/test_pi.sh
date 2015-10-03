#!/bin/bash

echo -e "[Test many methods to compute pi.Please wait...]"
make clean
make

file_dest="./Compute_result/"
log_file="rpi_compute_result"
file_type=".txt"

rm -rf $file_dest
mkdir -p $file_dest

N=(1000 2000 4000 8000 16000 32000 64000 128000 256000 512000 1024000 2048000)
for i in {0..2}
do
	for n in ${N[@]}
	do
		RUN="./pi_cal $i $n"

		file=$file_dest$log_file$i$file_type
		if test -s $file
			then
			$RUN >> $file 2>&1
		else
			$RUN > $file 2>&1
		fi
	done
done

echo -e "[Test many methods to compute pi is done.]"
