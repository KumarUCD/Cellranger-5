
## Guide to downloading and running this Docker image

### Step 1: Install Docker

To download and run intractive cellranger Docker image, you first need to install Docker on your computer. If you have Windows or Mac computer you can install the docker [click here](https://www.docker.com/products/docker-desktop) by simply downloading and clicking the installer which is available for both Mac and Windows. For Linux users, follow the instructions [here](https://docs.docker.com/linux/step_one/). 

### Step 2: Download and run the Docker image

#### Option 1: Through a Command Line Interface (CLI)

The image can be downloaded and executed through the CLI of Docker.

1. Pull(download) the Docker image:
	```
	$ docker pull sushilbt/interactive_cellranger-5:latest
	```
2. Run the Docker image. Enter in the directory where your raw data (data directory of .fastq files) stored.
	```	
	$ docker run --rm -p 8888:8888 -v "$PWD":/home/workspace  interactive_cellranger-5:latest
	```
3. Right click of http link and open it

4. Click the cellranger.ipnyb in left panel 


#### Option 2: Build your own docker using docker file and CLI

**Note:** You need to download github folder.

1. In terminal
          ```
          docker build -t interactive_cellranger-5:latest
          ```
2. Run the Docker image. Enter in the directory where your raw data (data directory of .fastq files) stored.
        ```	
	$ docker run --rm -p 8888:8888 -v "$PWD":/home/workspace  interactive_cellranger-5:latest
	```
3. Right click of http link and open it

4. Click the cellranger.ipnyb in left panel 

#### Option 3: Build your own docker using docker file and CLI directly from github

**Note:** You need not to download github folder.

1. In terminal
          ```
          docker build https://github.com/KumarUCD/Cellranger-5.git#main -t interactive_cellranger-5:latest
          ```
2. Run the Docker image. Enter in the directory where your raw data (data directory of .fastq files) stored.
        ```	
	$ docker run --rm -p 8888:8888 -v "$PWD":/home/workspace  interactive_cellranger-5:latest
	```
3. Right click of http link and open it

4. Click the cellranger.ipnyb in left panel 


# Jupyter lab Example
## Run intractive Cellranger for 10X single cell RNA sequence analysis on any os (tested on Ubuntu, Windows, Mac)



**Download human refrence genome index**


```bash
%%bash
wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz
```

    IOPub data rate exceeded.
    The Jupyter server will temporarily stop sending output
    to the client in order to avoid crashing it.
    To change this limit, set the config variable
    `--ServerApp.iopub_data_rate_limit`.
    
    Current values:
    ServerApp.iopub_data_rate_limit=1000000.0 (bytes/sec)
    ServerApp.rate_limit_window=3.0 (secs)
    
```bash
%%bash
tar -xzvf refdata-gex-GRCh38-2020-A.tar.gz
rm refdata-gex-GRCh38-2020-A.tar.gz
```

    refdata-gex-GRCh38-2020-A/
    refdata-gex-GRCh38-2020-A/pickle/
    refdata-gex-GRCh38-2020-A/pickle/genes.pickle
    refdata-gex-GRCh38-2020-A/fasta/
    refdata-gex-GRCh38-2020-A/fasta/genome.fa.fai
    refdata-gex-GRCh38-2020-A/fasta/genome.fa
    refdata-gex-GRCh38-2020-A/star/
    refdata-gex-GRCh38-2020-A/star/transcriptInfo.tab
    refdata-gex-GRCh38-2020-A/star/chrNameLength.txt
    refdata-gex-GRCh38-2020-A/star/SAindex
    refdata-gex-GRCh38-2020-A/star/geneInfo.tab
    refdata-gex-GRCh38-2020-A/star/SA
    refdata-gex-GRCh38-2020-A/star/exonInfo.tab
    refdata-gex-GRCh38-2020-A/star/chrStart.txt
    refdata-gex-GRCh38-2020-A/star/chrName.txt
    refdata-gex-GRCh38-2020-A/star/sjdbList.fromGTF.out.tab
    refdata-gex-GRCh38-2020-A/star/chrLength.txt
    refdata-gex-GRCh38-2020-A/star/sjdbInfo.txt
    refdata-gex-GRCh38-2020-A/star/genomeParameters.txt
    refdata-gex-GRCh38-2020-A/star/exonGeTrInfo.tab
    refdata-gex-GRCh38-2020-A/star/Genome
    refdata-gex-GRCh38-2020-A/star/sjdbList.out.tab
    refdata-gex-GRCh38-2020-A/genes/
    refdata-gex-GRCh38-2020-A/genes/genes.gtf
    refdata-gex-GRCh38-2020-A/reference.json


### Run Cellranger                                                                                                                                                                                                                             

```bash
%%bash
cellranger count --id=tinygex \
                 --transcriptome=/home/workspace/refdata-gex-GRCh38-2020-A \
                 --fastqs=/home/workspace/data \
                 --sample=tinygex  \
                 --expect-cells=5000 \
                 --localcores=4 \
                 --localmem=48
```

    Martian Runtime - v4.0.2
    2021-02-14 16:20:58 [jobmngr] WARNING: configured to use 48GB of local memory, but only 42.5GB is currently available.
    2021-02-14 16:20:58 [runtime] Reattaching in local mode.
    Serving UI at http://e22fcd0ca138:34919?auth=YWa_O8hPHyClSIIZ0Z7dH7p6zyvm5DFns1DrLL09QLM
    
    
    Outputs:
    - Run summary HTML:                         /home/workspace/tinygex/outs/web_summary.html
    - Run summary CSV:                          /home/workspace/tinygex/outs/metrics_summary.csv
    - BAM:                                      /home/workspace/tinygex/outs/possorted_genome_bam.bam
    - BAM index:                                /home/workspace/tinygex/outs/possorted_genome_bam.bam.bai
    - Filtered feature-barcode matrices MEX:    /home/workspace/tinygex/outs/filtered_feature_bc_matrix
    - Filtered feature-barcode matrices HDF5:   /home/workspace/tinygex/outs/filtered_feature_bc_matrix.h5
    - Unfiltered feature-barcode matrices MEX:  /home/workspace/tinygex/outs/raw_feature_bc_matrix
    - Unfiltered feature-barcode matrices HDF5: /home/workspace/tinygex/outs/raw_feature_bc_matrix.h5
    - Secondary analysis output CSV:            /home/workspace/tinygex/outs/analysis
    - Per-molecule read information:            /home/workspace/tinygex/outs/molecule_info.h5
    - CRISPR-specific analysis:                 null
    - Loupe Browser file:                       /home/workspace/tinygex/outs/cloupe.cloupe
    - Feature Reference:                        null
    - Target Panel File:                        null
    
    Waiting 6 seconds for UI to do final refresh.
    Pipestance completed successfully!
    
    2021-02-14 16:21:04 Shutting down.


### Visualize the summary and analysis


```python
from IPython.display import FileLinks
FileLinks(('tinygex/outs'), included_suffixes=['.html'])

```

tinygex/outs/<br>
&nbsp;&nbsp;<a href='tinygex/outs/web_summary.html' target='_blank'>web_summary.html</a><br>


