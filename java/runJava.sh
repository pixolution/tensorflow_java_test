#!/bin/bash

cd "$(dirname "$BASH_SOURCE")"
docker run -it -v "$(pwd):/work" -v "/tmp/vit_b32_fe/:/tmp/vit_b32_fe/" -w /work gradle:jdk11 gradle run
