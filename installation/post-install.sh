#!/bin/bash


source ~/.bashrc



conda activate h2ogpt.env

pip uninstall -y pandoc pypandoc pypandoc-binary


# CPU only:
pip install -r requirements.txt --extra-index https://download.pytorch.org/whl/cpu

# GPU only:
# pip install -r requirements.txt --extra-index https://download.pytorch.org/whl/cu117

# Required for Doc Q/A: LangChain:
pip install -r reqs_optional/requirements_optional_langchain.txt
# Required for CPU: LLaMa/GPT4All:
pip install -r reqs_optional/requirements_optional_gpt4all.txt
# Optional: PyMuPDF/ArXiv:
pip install -r reqs_optional/requirements_optional_langchain.gpllike.txt
# Optional: Selenium/PlayWright:
pip install -r reqs_optional/requirements_optional_langchain.urls.txt
# Optional: support docx, pptx, ArXiv, etc. required by some python packages
sudo apt-get install -y libmagic-dev poppler-utils tesseract-ocr libtesseract-dev libreoffice
# Optional: for supporting unstructured package
 
export NLTK_DATA=$(pwd)/nltk_data
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$(pwd)/cuda_home/lib64/
export CUDA_HOME=$(pwd)/cuda_home
export HF_HOME=$(pwd)/h_home


python -m nltk.downloader all
conda install cudatoolkit=11.7 -c conda-forge -y

USER_DATA_PATH="$(pwd)/user_data"

cd ..

python generate.py --base_model=h2oai/h2ogpt-4096-llama2-13b-chat --load_8bit=True  --score_model=None --langchain_mode='UserData' --user_path=$USER_DATA_PATH








