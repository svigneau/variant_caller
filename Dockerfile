FROM condaforge/mambaforge:latest
LABEL io.github.snakemake.containerized="true"
LABEL io.github.snakemake.conda_env_hash="43332af874bac14b739de6787e54faa6d9d83cdfa0138c76b0594daedd87daa6"

# Step 1: Retrieve conda environments

# Conda environment:
#   source: workflow/envs/bwa.yaml
#   prefix: /conda-envs/266ab5142a662252b3e0e86d1fbc2fe2
#   channels:
#     - bioconda
#     - conda-forge
#   dependencies:
#     - bwa = 0.7.17
RUN mkdir -p /conda-envs/266ab5142a662252b3e0e86d1fbc2fe2
COPY workflow/envs/bwa.yaml /conda-envs/266ab5142a662252b3e0e86d1fbc2fe2/environment.yaml

# Conda environment:
#   source: workflow/envs/freebayes.yaml
#   prefix: /conda-envs/6cca7821da1e098b4df1368649f25c3a
#   channels:
#     - bioconda
#     - conda-forge
#   dependencies:
#     - freebayes = 1.3.5
RUN mkdir -p /conda-envs/6cca7821da1e098b4df1368649f25c3a
COPY workflow/envs/freebayes.yaml /conda-envs/6cca7821da1e098b4df1368649f25c3a/environment.yaml

# Conda environment:
#   source: workflow/envs/samtools.yaml
#   prefix: /conda-envs/5c4499f7c7f8056ab105f8ae80b42fa9
#   channels:
#     - bioconda
#     - conda-forge
#   dependencies:
#     - samtools = 1.14
RUN mkdir -p /conda-envs/5c4499f7c7f8056ab105f8ae80b42fa9
COPY workflow/envs/samtools.yaml /conda-envs/5c4499f7c7f8056ab105f8ae80b42fa9/environment.yaml

# Step 2: Generate conda environments

RUN mamba env create --prefix /conda-envs/266ab5142a662252b3e0e86d1fbc2fe2 --file /conda-envs/266ab5142a662252b3e0e86d1fbc2fe2/environment.yaml && \
    mamba env create --prefix /conda-envs/6cca7821da1e098b4df1368649f25c3a --file /conda-envs/6cca7821da1e098b4df1368649f25c3a/environment.yaml && \
    mamba env create --prefix /conda-envs/5c4499f7c7f8056ab105f8ae80b42fa9 --file /conda-envs/5c4499f7c7f8056ab105f8ae80b42fa9/environment.yaml && \
    mamba clean --all -y
