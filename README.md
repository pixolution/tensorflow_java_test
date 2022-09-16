# Tensorflow java test

This repo contains code to reproduce the issue [#437](https://github.com/tensorflow/java/issues/473) in [tensorflow java bindings repository](https://github.com/tensorflow/) in version 0.5.0-SNAPSHOT.

## Usage

Make sure a recent version of docker is installed. Tested with Ubuntu 22.04 on x86_64. The Python and Java code is executed in docker containers
to have a reproducable environment.

### Run all at once
```
phoenix@dev:~/workspaces/research/tf_tests$ ./run.sh 2> /dev/null | grep "warm up"
Python: warm up finished in 4.694977925988496 seconds
Java: Model without ConfigProto, warm up took 6.797 seconds
```

* Model download
```
phoenix@dev:~/workspaces/research/tf_tests$ ./run.sh only_dl
Download model . . .
--2022-09-15 18:25:20--  https://tfhub.dev/sayakpaul/vit_b32_fe/1?tf-hub-format=compressed
Auflösen des Hostnamens tfhub.dev (tfhub.dev) … 142.250.186.174, 2a00:1450:4001:82b::200e
Verbindungsaufbau zu tfhub.dev (tfhub.dev)|142.250.186.174|:443 … verbunden.
HTTP-Anforderung gesendet, auf Antwort wird gewartet … 302 Found
Platz: https://storage.googleapis.com/tfhub-modules/sayakpaul/vit_b32_fe/1.tar.gz [folgend]
--2022-09-15 18:25:20--  https://storage.googleapis.com/tfhub-modules/sayakpaul/vit_b32_fe/1.tar.gz
Auflösen des Hostnamens storage.googleapis.com (storage.googleapis.com) … 142.250.185.240, 216.58.212.176, 142.250.74.208, ...
Verbindungsaufbau zu storage.googleapis.com (storage.googleapis.com)|142.250.185.240|:443 … verbunden.
HTTP-Anforderung gesendet, auf Antwort wird gewartet … 200 OK
Länge: 324615541 (310M) [application/octet-stream]
Wird in ‘/tmp/vit_b32_fe/vit_b32_fe_1.tar.gz’ gespeichert.

/tmp/vit_b32_fe/vit_b32_fe_1.tar.gz        100%[=====================================================================================>] 309,58M  23,4MB/s    in 13s     

2022-09-15 18:25:34 (23,7 MB/s) - ‘/tmp/vit_b32_fe/vit_b32_fe_1.tar.gz’ gespeichert [324615541/324615541]

Extract model . . .
Model can be loaded from /tmp/vit_b32_fe/
```

* Python test
```
phoenix@dev:~/workspaces/research/tf_tests$ ./python/runPython.sh
Collecting tensorflow==2.9.1
  Downloading tensorflow-2.9.1-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (511.7 MB)
     |████████████████████████████████| 511.7 MB 26.2 MB/s
Collecting tensorflow-hub==0.12.0
  Downloading tensorflow_hub-0.12.0-py2.py3-none-any.whl (108 kB)
     |████████████████████████████████| 108 kB 28.6 MB/s
Requirement already satisfied: tensorboard<2.10,>=2.9 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (2.9.0)
Requirement already satisfied: typing-extensions>=3.6.6 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (4.2.0)
Requirement already satisfied: tensorflow-io-gcs-filesystem>=0.23.1 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (0.26.0)
Requirement already satisfied: opt-einsum>=2.3.2 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (3.3.0)
Requirement already satisfied: keras-preprocessing>=1.1.1 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.1.2)
Requirement already satisfied: protobuf<3.20,>=3.9.2 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (3.19.4)
Requirement already satisfied: termcolor>=1.1.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.1.0)
Requirement already satisfied: keras<2.10.0,>=2.9.0rc0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (2.9.0)
Requirement already satisfied: astunparse>=1.6.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.6.3)
Requirement already satisfied: gast<=0.4.0,>=0.2.1 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (0.4.0)
Requirement already satisfied: flatbuffers<2,>=1.12 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.12)
Requirement already satisfied: h5py>=2.9.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (3.6.0)
Requirement already satisfied: grpcio<2.0,>=1.24.3 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.46.3)
Requirement already satisfied: numpy>=1.20 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.22.4)
Requirement already satisfied: six>=1.12.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.16.0)
Requirement already satisfied: libclang>=13.0.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (14.0.1)
Requirement already satisfied: setuptools in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (62.3.2)
Requirement already satisfied: packaging in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (21.3)
Requirement already satisfied: google-pasta>=0.1.1 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (0.2.0)
Requirement already satisfied: tensorflow-estimator<2.10.0,>=2.9.0rc0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (2.9.0)
Requirement already satisfied: wrapt>=1.11.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.14.1)
Requirement already satisfied: absl-py>=1.0.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.9.1->-r requirements.txt (line 1)) (1.0.0)
Requirement already satisfied: tensorboard-data-server<0.7.0,>=0.6.0 in /usr/local/lib/python3.8/dist-packages (from tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (0.6.1)
Requirement already satisfied: google-auth<3,>=1.6.3 in /usr/local/lib/python3.8/dist-packages (from tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (2.6.6)
Requirement already satisfied: markdown>=2.6.8 in /usr/local/lib/python3.8/dist-packages (from tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (3.3.7)
Requirement already satisfied: werkzeug>=1.0.1 in /usr/local/lib/python3.8/dist-packages (from tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (2.1.2)
Requirement already satisfied: google-auth-oauthlib<0.5,>=0.4.1 in /usr/local/lib/python3.8/dist-packages (from tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (0.4.6)
Requirement already satisfied: tensorboard-plugin-wit>=1.6.0 in /usr/local/lib/python3.8/dist-packages (from tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (1.8.1)
Requirement already satisfied: wheel>=0.26 in /usr/lib/python3/dist-packages (from tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (0.34.2)
Requirement already satisfied: requests<3,>=2.21.0 in /usr/local/lib/python3.8/dist-packages (from tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (2.27.1)
Requirement already satisfied: pyparsing!=3.0.5,>=2.0.2 in /usr/local/lib/python3.8/dist-packages (from packaging->tensorflow==2.9.1->-r requirements.txt (line 1)) (3.0.9)
Requirement already satisfied: pyasn1-modules>=0.2.1 in /usr/local/lib/python3.8/dist-packages (from google-auth<3,>=1.6.3->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (0.2.8)
Requirement already satisfied: cachetools<6.0,>=2.0.0 in /usr/local/lib/python3.8/dist-packages (from google-auth<3,>=1.6.3->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (5.1.0)
Requirement already satisfied: rsa<5,>=3.1.4; python_version >= "3.6" in /usr/local/lib/python3.8/dist-packages (from google-auth<3,>=1.6.3->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (4.8)
Requirement already satisfied: importlib-metadata>=4.4; python_version < "3.10" in /usr/local/lib/python3.8/dist-packages (from markdown>=2.6.8->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (4.11.4)
Requirement already satisfied: requests-oauthlib>=0.7.0 in /usr/local/lib/python3.8/dist-packages (from google-auth-oauthlib<0.5,>=0.4.1->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (1.3.1)
Requirement already satisfied: charset-normalizer~=2.0.0; python_version >= "3" in /usr/local/lib/python3.8/dist-packages (from requests<3,>=2.21.0->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (2.0.12)
Requirement already satisfied: urllib3<1.27,>=1.21.1 in /usr/local/lib/python3.8/dist-packages (from requests<3,>=2.21.0->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (1.26.9)
Requirement already satisfied: idna<4,>=2.5; python_version >= "3" in /usr/local/lib/python3.8/dist-packages (from requests<3,>=2.21.0->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (3.3)
Requirement already satisfied: certifi>=2017.4.17 in /usr/local/lib/python3.8/dist-packages (from requests<3,>=2.21.0->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (2022.5.18.1)
Requirement already satisfied: pyasn1<0.5.0,>=0.4.6 in /usr/local/lib/python3.8/dist-packages (from pyasn1-modules>=0.2.1->google-auth<3,>=1.6.3->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (0.4.8)
Requirement already satisfied: zipp>=0.5 in /usr/local/lib/python3.8/dist-packages (from importlib-metadata>=4.4; python_version < "3.10"->markdown>=2.6.8->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (3.8.0)
Requirement already satisfied: oauthlib>=3.0.0 in /usr/local/lib/python3.8/dist-packages (from requests-oauthlib>=0.7.0->google-auth-oauthlib<0.5,>=0.4.1->tensorboard<2.10,>=2.9->tensorflow==2.9.1->-r requirements.txt (line 1)) (3.2.0)
Installing collected packages: tensorflow, tensorflow-hub
Successfully installed tensorflow-2.9.1 tensorflow-hub-0.12.0
WARNING: You are using pip version 20.2.4; however, version 22.2.2 is available.
You should consider upgrading via the '/usr/bin/python3 -m pip install --upgrade pip' command.
2022-09-16 09:19:36.925258: I tensorflow/core/util/util.cc:169] oneDNN custom operations are on. You may see slightly different numerical results due to floating-point round-off errors from different computation orders. To turn them off, set the environment variable `TF_ENABLE_ONEDNN_OPTS=0`.
2022-09-16 09:19:36.929035: W tensorflow/stream_executor/platform/default/dso_loader.cc:64] Could not load dynamic library 'libcudart.so.11.0'; dlerror: libcudart.so.11.0: cannot open shared object file: No such file or directory
2022-09-16 09:19:36.929046: I tensorflow/stream_executor/cuda/cudart_stub.cc:29] Ignore above cudart dlerror if you do not have a GPU set up on your machine.
Loading saved model from /tmp/vit_b32_fe/
2022-09-16 09:19:37.986509: W tensorflow/stream_executor/platform/default/dso_loader.cc:64] Could not load dynamic library 'libcuda.so.1'; dlerror: libcuda.so.1: cannot open shared object file: No such file or directory
2022-09-16 09:19:37.986530: W tensorflow/stream_executor/cuda/cuda_driver.cc:269] failed call to cuInit: UNKNOWN ERROR (303)
2022-09-16 09:19:37.986550: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:156] kernel driver does not appear to be running on this host (8e703ab9f298): /proc/driver/nvidia/version does not exist
2022-09-16 09:19:37.986689: I tensorflow/core/platform/cpu_feature_guard.cc:193] This TensorFlow binary is optimized with oneAPI Deep Neural Network Library (oneDNN) to use the following CPU instructions in performance-critical operations:  AVX2 AVX_VNNI FMA
To enable them in other operations, rebuild TensorFlow with the appropriate compiler flags.
2022-09-16 09:19:40.909455: I tensorflow/compiler/xla/service/service.cc:170] XLA service 0x1cac60c0 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2022-09-16 09:19:40.909480: I tensorflow/compiler/xla/service/service.cc:178]   StreamExecutor device (0): Host, Default Version
2022-09-16 09:19:41.005726: I tensorflow/compiler/mlir/tensorflow/utils/dump_mlir_util.cc:263] disabling MLIR crash reproducer, set env var `MLIR_CRASH_REPRODUCER_DIRECTORY` to enable.
2022-09-16 09:19:45.697414: I tensorflow/compiler/jit/xla_compilation_cache.cc:478] Compiled cluster using XLA!  This line is logged at most once for the lifetime of the process.
Python: warm up without flags finished in 4.988460940003279 seconds
```

* Java test
```
phoenix@dev:~/workspaces/research/tf_tests$ ./java/runJava.sh

Welcome to Gradle 7.5.1!

Here are the highlights of this release:
 - Support for Java 18
 - Support for building with Groovy 4
 - Much more responsive continuous builds
 - Improved diagnostics for dependency resolution

For more details see https://docs.gradle.org/7.5.1/release-notes.html

Starting a Gradle Daemon (subsequent builds will be faster)

> Task :run
Testing query without ConfigProto
2022-09-16 09:21:51.859288: I external/org_tensorflow/tensorflow/core/util/util.cc:169] oneDNN custom operations are on. You may see slightly different numerical results due to floating-point round-off errors from different computation orders. To turn them off, set the environment variable `TF_ENABLE_ONEDNN_OPTS=0`.
2022-09-16 09:21:53.094691: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:43] Reading SavedModel from: /tmp/vit_b32_fe/
2022-09-16 09:21:53.139816: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:81] Reading meta graph with tags { serve }
2022-09-16 09:21:53.139846: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:122] Reading SavedModel debug info (if present) from: /tmp/vit_b32_fe/
2022-09-16 09:21:53.139895: I external/org_tensorflow/tensorflow/core/platform/cpu_feature_guard.cc:193] This TensorFlow binary is optimized with oneAPI Deep Neural Network Library (oneDNN) to use the following CPU instructions in performance-critical operations:  AVX2 AVX_VNNI FMA
To enable them in other operations, rebuild TensorFlow with the appropriate compiler flags.
2022-09-16 09:21:53.241442: I external/org_tensorflow/tensorflow/compiler/mlir/mlir_graph_optimization_pass.cc:354] MLIR V1 optimization pass is not enabled
2022-09-16 09:21:53.268674: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:228] Restoring SavedModel bundle.
2022-09-16 09:21:53.828554: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:212] Running initialization op on SavedModel bundle at path: /tmp/vit_b32_fe/
2022-09-16 09:21:54.105540: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:301] SavedModel load for tags { serve }; Status: success: OK. Took 1010852 microseconds.
2022-09-16 09:21:56.018744: I external/org_tensorflow/tensorflow/compiler/xla/service/service.cc:170] XLA service 0x7f57a4014ec0 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2022-09-16 09:21:56.018777: I external/org_tensorflow/tensorflow/compiler/xla/service/service.cc:178]   StreamExecutor device (0): Host, Default Version
2022-09-16 09:21:56.062819: I external/org_tensorflow/tensorflow/compiler/mlir/tensorflow/utils/dump_mlir_util.cc:263] disabling MLIR crash reproducer, set env var `MLIR_CRASH_REPRODUCER_DIRECTORY` to enable.
2022-09-16 09:22:00.695902: I external/org_tensorflow/tensorflow/compiler/jit/xla_compilation_cache.cc:478] Compiled cluster using XLA!  This line is logged at most once for the lifetime of the process.
Java: Model without ConfigProto, warm up took 6.047 seconds

BUILD SUCCESSFUL in 38s
2 actionable tasks: 1 executed, 1 up-to-date
```
