#!/bin/bash

cd "$(dirname "$BASH_SOURCE")"
docker run -it -w /work -v "$(pwd):/work" -v "/tmp/vit_b32_fe/:/tmp/vit_b32_fe/" tensorflow/tensorflow:2.9.1 bash -c "pip3 install -r requirements.txt && python3 main.py"
