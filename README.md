# BalanSiNG: Fast and Scalable Generation of Realistic Signed Networks

This repository contains codes and datasets used in the following paper:
* BalanSiNG: Fast and Scalable Generation of Realistic Signed Networks, submitted to EDBT 2020.

## Overview
How can we efficiently generate large-scale signed networks following real-world properties?
Due to its rich modeling capability of representing trust relations as positive and negative edges,
signed networks have spurred much interests with various applications.
Despite its importance, however, existing models for generating signed networks do not correctly reflect properties of real-world graphs.

In this paper, we propose BalanSiNG, a novel, scalable, and fully parallelizable method for generating large-scale signed networks following realistic properties.
We identify a self-similar balanced structure observed from a real-world signed network, and simulate the self-similarity via Kronecker product.
Then, we exploit noise and careful weighting of signs
such that our resulting network obeys various properties of real-world signed networks.
BalanSiNG is easily parallelizable, and we implement it using Spark.
Extensive experiments show that BalanSiNG efficiently generates the most realistic signed networks satisfying various desired properties. 

## Datasets
The datasets used in this paper are available at this repository. 

## Usages
We provide two implementations for BalanSiNG based on `scala` with `spark` and `c++`.

### How to run scala code
The `scala` code is located in `spark-scala/balansing` working on `spark` for generating signed edges in parallel.
You can check the demo of this code by typing the following commands in a terminal:
```bash
bash run.sh
```
To run the above demo, you should install java, scala, hadoop, and spark in your machines. The tested environment is as follows:
* Java v1.8.0
* Scala v2.11.8
* Hadoop v2.7.3
* Spark v2.11.9

The parameters used in the shell are as follows:
* The target recursion depth L, `level = 12`
* The number of edges E, `numEdges=24186`
* The number of tasks, `numTasks=2` (i.e., how many tasks generate signed edges in parallel.)
* The seed parameter, `p11=0.57`
* The seed parameter, `m12=0.19`
* The seed parameter, `m21=0.19`
* The seed parameter, `p22=0.57`
* The parameter for weight spltting, `alpha=0.85`
* The parameter for noise, `gamma=0.1`
* The output path, `OUTPUT=result` (i.e., The output files are stored at `OUTPUT` (e.g., `./result`). 

You can import the project using IntelliJ with sbt to modify the code. 

### How to run c++ code
The `c++` code is located in `cpp` directory, and based on mex of matlab which allows users to easily analyze signed networks generated by `BalanSiNG` with various visual plots. 
You can check the demo of this code by typing the following commands in matlab:
```matlab
run_demo
```
The parameters used in the demo are as follows:
* The seed stochastic adjacency matrix for positive edges, `P = [0.57, 0; 0, 0.05]`
* The seed stochastic adjacency matrix for negative edges: `M = [0, 0.19; 0.19, 0]`
    * The stochastic signed tensor is represented as `T = {+P, -M}`, and they are simply represented as `A = P + M`
* The target recursion depth, `L = 12`
* The number of edges, `E = 24186`
* The parameter for weight spltting, `alpha = 0.85`
* The parameter for noise, `gamma = 0.1`

You can obtain an adjacency list (e.g., `[{source, target, sign}]`) generated by `BalanSiNG` using `cpp/BalanSiNG.m` which provides an interface between matlab and `cpp/GenerateEdgesBalanSiNG.cpp` generating signed edges based on `c++`.
The input and output of `cpp/BalanSiNG.m` are as follows:

```matlab
function [X] = BalanSiNG(L, E, A, alpha, gamma)
%% Input
% L: target recursion depth (scalar), i.e., |V| = 2^L
% E: target number of edges (scalar)
% A: seed adjacency tensor (2 x 2 matrix), i.e., A = P + M
% gamma: parameter for noise (scalar)
% alpha: parameter for weight splitting (scalar)

%% Output
% X: signed adjacency list (E x 3 matrix), [source, target, sign]
end
```
