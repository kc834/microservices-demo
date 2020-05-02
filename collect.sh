#!/bin/bash

start=`date +%s`
for r in $(seq 1000 1000 10000)
do
	for c in $(seq 10 10 100)
	do
		docker run --net=host weaveworksdemos/load-test -h localhost -r $r -c $c
	done
done
end=`date +%s`
runtime=$((end-start))
python query_csv_all.py http://localhost:9090 $runtime | gzip > output/$(date +"%Y_%m_%d_%I_%M_%S_%p")_metrics.gz