#!/bin/bash

NLTK_DATA_PATH="$(pwd)/nltk_data"
MINICINDA3_INSTALLATION_PATH="$(pwd)/miniconda3"

export NLTK_DATA=$NLTK_DATA_PATH

sudo apt-get install -y build-essential gcc

wget -O "Miniconda3-py310_23.1.0-1-Linux-x86_64.sh" "https://repo.anaconda.com/miniconda/Miniconda3-py310_23.1.0-1-Linux-x86_64.sh"


echo "Miniconda3 instalation path"
echo $MINICINDA3_INSTALLATION_PATH

bash ./Miniconda3-py310_23.1.0-1-Linux-x86_64.sh -u
# follow license agreement and add to bash if required

source ~/.bashrc

conda config --set auto_activate_base false

conda create -n h2ogpt.env -y
conda activate h2ogpt.env
conda install python=3.10 -c conda-forge -y

python --version
python -c "import os, sys ; print('Python stdout test works')"

pip --version

# Cuda Download Installer for Linux Ubuntu 22.04 x86_64
wget -O "cuda-ubuntu2204.pin" "https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin"
sudo cp ./cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget -O "cuda-repo-ubuntu2204-12-2-local_12.2.1-535.86.10-1_amd64.deb" "https://developer.download.nvidia.com/compute/cuda/12.2.1/local_installers/cuda-repo-ubuntu2204-12-2-local_12.2.1-535.86.10-1_amd64.deb"
sudo dpkg -i cuda-repo-ubuntu2204-12-2-local_12.2.1-535.86.10-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-2-local/cuda-*-keyring.gpg /usr/share/keyrings/

sudo apt-get update
sudo apt-get -y install cuda

echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64/" >> ~/.bashrc
echo "export CUDA_HOME=/usr/local/cuda" >> ~/.bashrc
echo "export PATH=\$PATH:/usr/local/cuda/bin/" >> ~/.bashrc
source ~/.bashrc

conda activate h2ogpt.env

# Cuda Download Installer non-dev version
conda install cudatoolkit=11.7 -c conda-forge -y

conda activate h2ogpt.env

sudo reboot










