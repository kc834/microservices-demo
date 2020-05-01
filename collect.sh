#!/bin/bash

for r in $(seq 100 100 1000)
do
	for c in {1..10}
	do
		start=`date +%s`
		docker run --net=host weaveworksdemos/load-test -h localhost -r $r -c $c
		end=`date +%s`
		runtime=$((end-start))
		python query_csv_all.py http://localhost:9090 $runtime | gzip > output/$(date +"%Y_%m_%d_%I_%M_%S_%p")_metrics.gz
		
	done
done
