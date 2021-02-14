# use Ubuntu 20.04 base image
FROM ubuntu:20.04
MAINTAINER Sushil Kumar <Sushil.Kumar@cuanschutz.edu>

# run as root user
USER root

ENV DEBIAN_FRONTEND noninteractive

# Install OS packages
# r-cran-nloptr is installed here because it is required for R package ez but will not install via R command line
RUN apt-get update && apt-get install -y \
    axel \
    curl \
    locales \
    unzip \
    wget \
    && \
 rm -rf /var/lib/apt/lists/*
 
 RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV SHELL=/bin/bash \
    Notebook_USER=datawrangler \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
    
# Install python3 and pip package manager
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip 

# Install python3 packages 
RUN pip3 install \
    jupyter \
    jupyter_contrib_nbextensions \
    jupyterlab \
    jupytext \
    xlrd

# Configure Jupyter notebook
RUN jupyter notebook --generate-config && \
    ipython profile create
# TextFileContentsManager is needed to jupytext
RUN echo "c.NotebookApp.open_browser = False" >>/root/.jupyter/jupyter_notebook_config.py && \
    echo "c.InteractiveShellApp.matplotlib = 'inline'" >>/root/.ipython/profile_default/ipython_config.py && \
    echo "c.NotebookApp.contents_manager_class = 'jupytext.TextFileContentsManager'" >>/root/.jupyter/jupyter_notebook_config.py

# install notebook kernel for Python 3
RUN python3 -m pip install ipykernel
RUN python3 -m ipykernel install --user
RUN python3 -m pip install bash_kernel
RUN python3 -m bash_kernel.install

# Run the Jupyter lab .. comment the first command because it is only for the notebook
 CMD jupyter lab --allow-root --ip 0.0.0.0 --no-browser

####################################################################################################
##  Install cellranger-5.0.1
####################################################################################################
USER root

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

# Set the default directory where CMD will execute
WORKDIR /home
# Set environment variable
ENV HOME=/home

# downloads cell ranger 5.0
RUN wget -O cellranger-5.0.1.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-5.0.1.tar.gz?Expires=1613321371&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1leHAvY2VsbHJhbmdlci01LjAuMS50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2MTMzMjEzNzF9fX1dfQ__&Signature=h6RmGb1gg~5rjHKxDIzWLtnoGu~ZLfcL~dLRaEMdSVhNCT6tiA13IelXynp78lMCI1lXktqAWYAJwoMAA~856BKtJ7xmWur86g2LYrFZQPnP32WSUS3E0ss0HDctc2yXRoQNCABsG~k0c9sENQoM4j4C3Vy7LfTA5qDQn0v1Hwfvq6UG3cP0PYbKIaUOgKnFlHNQ~PmiJx0jIySfQY5DCs6S4MtBobNZn353CUhGOb-SYIz0QHiDTKKKFspdHJuzO0eJdhIQYBOL96nT99USZeNca-fKItWyqNCfzGtuFrwMgdW~5QlXbZozZPft8kBT0fmyWeJKWitLcuFvcCtUkQ__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"
RUN tar -xzvf cellranger-5.0.1.tar.gz
# Clean-ups
RUN rm *.gz  

ENV PATH="/home/cellranger-5.0.1:${PATH}"
RUN export PATH=/home/cellranger-5.0.1:$PATH
RUN echo "export PATH=\${PATH}:/home/cellranger-5.0.1" >> /home/.bashrc  
##################################################################################################3
RUN mkdir -p /home/workspace
ENV PATH="$HOME/work:${PATH}"

WORKDIR /home/workspace
RUN pwd

# Expose port to host
EXPOSE 8888
