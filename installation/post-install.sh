#!/bin/bash


source ~/.bashrc


echo "# - post install add start - #" >> ./source-profile
echo "export NLTK_DATA=$(pwd)/nltk_data" >> ./source-profile
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$(pwd)/cuda_home/lib64/ " >> ./source-profile
echo "export CUDA_HOME=$(pwd)/cuda_home" >> ./source-profile
echo "export HF_HOME=$(pwd)/hf_home" >> ./source-profile
echo "export USER_DATA_PATH=$(pwd)/user_data" >> ./source-profile
echo "# - post install add end - #" >> ./source-profile 


conda activate h2ogpt.env
source ./source-profile

pip uninstall -y pandoc pypandoc pypandoc-binary

# CPU only:
pip install -r ../requirements.txt --extra-index https://download.pytorch.org/whl/cpu --no-cache-dir

# GPU only:
# pip install -r ../requirements.txt --extra-index https://download.pytorch.org/whl/cu117

# Required for Doc Q/A: LangChain:
pip install -r ../reqs_optional/requirements_optional_langchain.txt --no-cache-dir
# Required for CPU: LLaMa/GPT4All:
pip install -r ../reqs_optional/requirements_optional_gpt4all.txt --no-cache-dir
# Optional: PyMuPDF/ArXiv:
pip install -r ../reqs_optional/requirements_optional_langchain.gpllike.txt --no-cache-dir
# Optional: Selenium/PlayWright:
pip install -r ../reqs_optional/requirements_optional_langchain.urls.txt --no-cache-dir
# Optional: support docx, pptx, ArXiv, etc. required by some python packages
sudo apt-get install -y libmagic-dev poppler-utils tesseract-ocr libtesseract-dev libreoffice
# Optional: for supporting unstructured package

source ./source-profile

python -m nltk.downloader all
# conda install cudatoolkit=11.7 -c conda-forge -y
 
source ./source-profile

# cd ..
testCommand="python generate.py --base_model=h2oai/h2ogpt-4096-llama2-13b-chat --load_8bit=True  --score_model=None --langchain_mode='UserData' --user_path=$USER_DATA_PATH"

echo "Install done!"
echo "Go back to the root folder then, Try to run:"
echo "$testCommand"











