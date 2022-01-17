Variant calling pipeline that takes paired end short read data (fastq files) and a reference genome (fasta file) as inputs and output variant calls (vcf file).
The pipeline uses snakemake, bwa, samtools, and freebayes.

Before running the pipeline:
- add paired end short read fastq files to the fastq/ directory
- add reference genome fastq file to the ref/ directory 
- edit config/config.yaml file with the base name and extension of the fastq files and the name of the fasta file 

The pipeline can be run with one of the following commands:
- `snakemake --cores [number of cores]` uses local dependencies
- `snakemake --cores [number of cores] --use-conda` uses snakemake integrated package management to fetch dependencies from conda repository and create self-contained environments
- `snakemake --cores [number of cores] --use-conda --use-singularity` uses snakemake integrated package management within a Docker container created from DockerHub (docker://svigneau/variant_caller) and carrying the required dependencies

**Notes:**

Unit tests generated with `snakemake --generate-unit-tests` were modified to do the following:
- handle config and log files as described in: https://github.com/snakemake/snakemake/issues/843#issuecomment-832566353
- remove date line from vcf files

**To do:**
- add fastqc [DONE]
- add multiqc
- mark duplicates [DONE]
- filter VCF using QUAL and DP [DONE]
- annotate VCF with SNPeff or VEP
- add unit tests for new rules
- update Dockerfile and Docker image with new environments
- use os.path.join for paths in Snakefile
- use snakemake wrappers
