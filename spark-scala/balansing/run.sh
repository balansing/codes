#!/bin/bash

level=12
numEdges=24186
numTasks=2
a=0.57
b=0.19
c=0.19
d=0.57
alpha=0.15
gamma=0.1
OUTPUT=result
randSeed=0

JAR_PATH=./target/scala-2.11/balansing_2.11-0.1.jar

if [ -d "$OUTPUT" ]; then
    rm -rf ${OUTPUT}
fi

spark-submit --master local \
       --deploy-mode client \
       --num-executors $numTasks \
       --driver-memory 5G \
       --conf spark.network.timeout=10000000 \
       --executor-cores 1 --executor-memory 2g \
       --class spark.BalanSiNG \
       ${JAR_PATH} $level $numEdges $numTasks $a $b $c $d $alpha $gamma $OUTPUT $randSeed

