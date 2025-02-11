#!/bin/bash

uv venv .venv --python 3.12 --seed
source .venv/bin/activate
docker pull cphsieh/ruler:0.2.0
cd ./scripts/data/synthetic/json
uv pip install bs4 html2text tqdm
python download_paulgraham_essay.py
bash download_qa_dataset.sh
git config --global user.email "mikelasby@cohere.com"
git config --global user.name "Mike Lasby"