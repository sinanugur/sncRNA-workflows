# sncRNA workflow
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) 

A small ncRNA workflow in Snakemake.



Installation
------------
To install this workflow, clone the repo:

```
git clone https://github.com/sinanugur/sncRNA-workflows.git
cd sncRNA-workflow

```

Quick start example
-------------------
Create a new directory called __data__ and place your FASTQ files or their symbolic links into `data/` directory. You need an active Conda installation with Snakemake. You do not have to install any other requirements. This will trigger a workflow run immediately using 15 threads:

```
snakemake -j 15 --use-conda
```

Databases
---------------------
```

```


Output
------
This workflow will generate `results/` directory. 

This directory contains count tables and sample statistics.

Citiation
---------
This workflow is adapted from our small RNA analysis study. Please cite if you find this useful: https://doi.org/10.1080/15476286.2017.1403003

Funding
---------
The study was funded by the Research Council of Norway under the Program Human Biobanks and Health Data (grant numbers 229621/H10 and 248791/H10) and the EULAT EradicateGBC project. 


