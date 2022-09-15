#!/bin/bash

set -e

cd "$(dirname "$BASH_SOURCE")"
WD="$(pwd)"

# download model to temp location
if [ ! -d "/tmp/vit_b32_fe/" ]; then
  echo "Download model . . ."
  mkdir -p "/tmp/vit_b32_fe"
  wget "https://tfhub.dev/sayakpaul/vit_b32_fe/1?tf-hub-format=compressed" -O "/tmp/vit_b32_fe/vit_b32_fe_1.tar.gz"
fi

# unpack saved model
if [ ! -f "/tmp/vit_b32_fe/saved_model.pb" ]; then
  echo "Extract model . . ."
  cd /tmp/vit_b32_fe/
  tar xfz vit_b32_fe_1.tar.gz
  cd "$WD"
fi

echo
echo "Running python"
echo
./python/runPython.sh

echo "Model can be loaded from /tmp/vit_b32_fe/"
echo
echo "Running java"
echo
./java/runJava.sh

