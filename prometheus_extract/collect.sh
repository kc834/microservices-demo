#!/bin/bash

for r in {1000..100000..1000}
do
	for c in {10..1000..10}
	do
		start=`date +%s`
		docker run --net=host weaveworksdemos/load-test -h localhost -r $r -c $c
		end=`date +%s`
		runtime=$((end-start))
		python query_csv_all.py http://localhost:9090 $runtime | gzip > $(date +"%Y_%m_%d_%I_%M_%p")_metrics.gz
	done
done
