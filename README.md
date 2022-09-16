# Tensorflow java test

This repo contains code to reproduce the issue [#437](https://github.com/tensorflow/java/issues/473) in [tensorflow java bindings repository](https://github.com/tensorflow/) in version 0.4.1.

## Usage

Make sure a recent version of docker is installed. Tested with Ubuntu 22.04 on x86_64. The Python and Java code is executed in docker containers
to have a reproducable environment.

### Run all at once
```
phoenix@dev:~/workspaces/research/tf_tests$ ./run.sh 2> /dev/null | grep "warm up"
Python: warm up finished in 29.75354215799598 seconds
Java: Model without ConfigProto, warm up took 29.337 seconds
Java: Model with ConfigProto/disabled JIT, warm up took 29.55 seconds
```


### Run each test (python, java) individually
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
Collecting tensorflow==2.7.1
  Downloading tensorflow-2.7.1-cp38-cp38-manylinux2010_x86_64.whl (495.1 MB)
     |████████████████████████████████| 495.1 MB 35 kB/s
Collecting tensorflow-hub==0.12.0
  Downloading tensorflow_hub-0.12.0-py2.py3-none-any.whl (108 kB)
     |████████████████████████████████| 108 kB 18.6 MB/s
Requirement already satisfied: wrapt>=1.11.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (1.13.3)
Requirement already satisfied: flatbuffers<3.0,>=1.12 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (2.0)
Requirement already satisfied: gast<0.5.0,>=0.2.1 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (0.4.0)
Requirement already satisfied: protobuf>=3.9.2 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (3.19.4)
Requirement already satisfied: keras<2.8,>=2.7.0rc0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (2.7.0)
Requirement already satisfied: wheel<1.0,>=0.32.0 in /usr/lib/python3/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (0.34.2)
Requirement already satisfied: six>=1.12.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (1.16.0)
Requirement already satisfied: tensorflow-estimator<2.8,~=2.7.0rc0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (2.7.0)
Requirement already satisfied: typing-extensions>=3.6.6 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (4.0.1)
Requirement already satisfied: numpy>=1.14.5 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (1.22.1)
Requirement already satisfied: absl-py>=0.4.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (1.0.0)
Requirement already satisfied: h5py>=2.9.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (3.6.0)
Requirement already satisfied: keras-preprocessing>=1.1.1 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (1.1.2)
Requirement already satisfied: tensorboard~=2.6 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (2.8.0)
Requirement already satisfied: google-pasta>=0.1.1 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (0.2.0)
Requirement already satisfied: opt-einsum>=2.3.2 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (3.3.0)
Requirement already satisfied: termcolor>=1.1.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (1.1.0)
Requirement already satisfied: astunparse>=1.6.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (1.6.3)
Requirement already satisfied: tensorflow-io-gcs-filesystem>=0.21.0 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (0.23.1)
Requirement already satisfied: libclang>=9.0.1 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (13.0.0)
Requirement already satisfied: grpcio<2.0,>=1.24.3 in /usr/local/lib/python3.8/dist-packages (from tensorflow==2.7.1->-r requirements.txt (line 1)) (1.43.0)
Requirement already satisfied: requests<3,>=2.21.0 in /usr/local/lib/python3.8/dist-packages (from tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (2.27.1)
Requirement already satisfied: google-auth-oauthlib<0.5,>=0.4.1 in /usr/local/lib/python3.8/dist-packages (from tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (0.4.6)
Requirement already satisfied: setuptools>=41.0.0 in /usr/local/lib/python3.8/dist-packages (from tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (60.7.0)
Requirement already satisfied: tensorboard-data-server<0.7.0,>=0.6.0 in /usr/local/lib/python3.8/dist-packages (from tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (0.6.1)
Requirement already satisfied: google-auth<3,>=1.6.3 in /usr/local/lib/python3.8/dist-packages (from tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (2.6.0)
Requirement already satisfied: tensorboard-plugin-wit>=1.6.0 in /usr/local/lib/python3.8/dist-packages (from tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (1.8.1)
Requirement already satisfied: markdown>=2.6.8 in /usr/local/lib/python3.8/dist-packages (from tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (3.3.6)
Requirement already satisfied: werkzeug>=0.11.15 in /usr/local/lib/python3.8/dist-packages (from tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (2.0.2)
Requirement already satisfied: urllib3<1.27,>=1.21.1 in /usr/local/lib/python3.8/dist-packages (from requests<3,>=2.21.0->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (1.26.8)
Requirement already satisfied: certifi>=2017.4.17 in /usr/local/lib/python3.8/dist-packages (from requests<3,>=2.21.0->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (2021.10.8)
Requirement already satisfied: charset-normalizer~=2.0.0; python_version >= "3" in /usr/local/lib/python3.8/dist-packages (from requests<3,>=2.21.0->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (2.0.11)
Requirement already satisfied: idna<4,>=2.5; python_version >= "3" in /usr/local/lib/python3.8/dist-packages (from requests<3,>=2.21.0->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (3.3)
Requirement already satisfied: requests-oauthlib>=0.7.0 in /usr/local/lib/python3.8/dist-packages (from google-auth-oauthlib<0.5,>=0.4.1->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (1.3.1)
Requirement already satisfied: pyasn1-modules>=0.2.1 in /usr/local/lib/python3.8/dist-packages (from google-auth<3,>=1.6.3->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (0.2.8)
Requirement already satisfied: cachetools<6.0,>=2.0.0 in /usr/local/lib/python3.8/dist-packages (from google-auth<3,>=1.6.3->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (5.0.0)
Requirement already satisfied: rsa<5,>=3.1.4; python_version >= "3.6" in /usr/local/lib/python3.8/dist-packages (from google-auth<3,>=1.6.3->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (4.8)
Requirement already satisfied: importlib-metadata>=4.4; python_version < "3.10" in /usr/local/lib/python3.8/dist-packages (from markdown>=2.6.8->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (4.10.1)
Requirement already satisfied: oauthlib>=3.0.0 in /usr/local/lib/python3.8/dist-packages (from requests-oauthlib>=0.7.0->google-auth-oauthlib<0.5,>=0.4.1->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (3.2.0)
Requirement already satisfied: pyasn1<0.5.0,>=0.4.6 in /usr/local/lib/python3.8/dist-packages (from pyasn1-modules>=0.2.1->google-auth<3,>=1.6.3->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (0.4.8)
Requirement already satisfied: zipp>=0.5 in /usr/local/lib/python3.8/dist-packages (from importlib-metadata>=4.4; python_version < "3.10"->markdown>=2.6.8->tensorboard~=2.6->tensorflow==2.7.1->-r requirements.txt (line 1)) (3.7.0)
Installing collected packages: tensorflow, tensorflow-hub
Successfully installed tensorflow-2.7.1 tensorflow-hub-0.12.0
WARNING: You are using pip version 20.2.4; however, version 22.2.2 is available.
You should consider upgrading via the '/usr/bin/python3 -m pip install --upgrade pip' command.
2022-09-16 09:00:26.908495: W tensorflow/stream_executor/platform/default/dso_loader.cc:64] Could not load dynamic library 'libcudart.so.11.0'; dlerror: libcudart.so.11.0: cannot open shared object file: No such file or directory
2022-09-16 09:00:26.908512: I tensorflow/stream_executor/cuda/cudart_stub.cc:29] Ignore above cudart dlerror if you do not have a GPU set up on your machine.
Loading saved model from /tmp/vit_b32_fe/
2022-09-16 09:00:27.928676: W tensorflow/stream_executor/platform/default/dso_loader.cc:64] Could not load dynamic library 'libcuda.so.1'; dlerror: libcuda.so.1: cannot open shared object file: No such file or directory
2022-09-16 09:00:27.928693: W tensorflow/stream_executor/cuda/cuda_driver.cc:269] failed call to cuInit: UNKNOWN ERROR (303)
2022-09-16 09:00:27.928710: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:156] kernel driver does not appear to be running on this host (46149c4e2299): /proc/driver/nvidia/version does not exist
2022-09-16 09:00:27.928833: I tensorflow/core/platform/cpu_feature_guard.cc:151] This TensorFlow binary is optimized with oneAPI Deep Neural Network Library (oneDNN) to use the following CPU instructions in performance-critical operations:  AVX2 FMA
To enable them in other operations, rebuild TensorFlow with the appropriate compiler flags.
2022-09-16 09:00:30.889673: I tensorflow/compiler/xla/service/service.cc:171] XLA service 0x1c53810 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2022-09-16 09:00:30.889696: I tensorflow/compiler/xla/service/service.cc:179]   StreamExecutor device (0): Host, Default Version
2022-09-16 09:00:30.986100: I tensorflow/compiler/mlir/tensorflow/utils/dump_mlir_util.cc:237] disabling MLIR crash reproducer, set env var `MLIR_CRASH_REPRODUCER_DIRECTORY` to enable.
2022-09-16 09:01:00.485074: I tensorflow/compiler/jit/xla_compilation_cache.cc:351] Compiled cluster using XLA!  This line is logged at most once for the lifetime of the process.
Python: warm up without flags finished in 29.776419711997733 seconds
```
 * Java test
```
phoenix@dev:~/workspaces/research/tf_tests$ ./java/runJava.sh
Unable to find image 'gradle:jdk11' locally
jdk11: Pulling from library/gradle
2b55860d4c66: Pull complete
2ca45fc4c4ca: Pull complete
eb243d873b24: Pull complete
d6f7a10724bf: Pull complete
a3ab1420a0b8: Pull complete
cce79b34bca6: Pull complete
0ed7e1c5f6e3: Pull complete
Digest: sha256:b17228e1879682599d35c390156732f3a33f917ca00352955e76a3f8822b46ce
Status: Downloaded newer image for gradle:jdk11

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
2022-09-16 09:02:34.933849: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:43] Reading SavedModel from: /tmp/vit_b32_fe/
2022-09-16 09:02:34.975552: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:107] Reading meta graph with tags { serve }
2022-09-16 09:02:34.975586: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:148] Reading SavedModel debug info (if present) from: /tmp/vit_b32_fe/
2022-09-16 09:02:34.975636: I external/org_tensorflow/tensorflow/core/platform/cpu_feature_guard.cc:151] This TensorFlow binary is optimized with oneAPI Deep Neural Network Library (oneDNN) to use the following CPU instructions in performance-critical operations:  AVX2 FMA
To enable them in other operations, rebuild TensorFlow with the appropriate compiler flags.
2022-09-16 09:02:35.127803: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:228] Restoring SavedModel bundle.
2022-09-16 09:02:35.666266: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:212] Running initialization op on SavedModel bundle at path: /tmp/vit_b32_fe/
2022-09-16 09:02:35.935276: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:301] SavedModel load for tags { serve }; Status: success: OK. Took 1001433 microseconds.
2022-09-16 09:02:37.745691: I external/org_tensorflow/tensorflow/compiler/xla/service/service.cc:171] XLA service 0x7fc0d8015570 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
2022-09-16 09:02:37.745722: I external/org_tensorflow/tensorflow/compiler/xla/service/service.cc:179]   StreamExecutor device (0): Host, Default Version
2022-09-16 09:02:37.784611: I external/org_tensorflow/tensorflow/compiler/mlir/tensorflow/utils/dump_mlir_util.cc:237] disabling MLIR crash reproducer, set env var `MLIR_CRASH_REPRODUCER_DIRECTORY` to enable.
2022-09-16 09:03:07.309130: I external/org_tensorflow/tensorflow/compiler/jit/xla_compilation_cache.cc:351] Compiled cluster using XLA!  This line is logged at most once for the lifetime of the process.
Java: Model without ConfigProto, warm up took 30.933 seconds

Testing query with ConfigProto
2022-09-16 09:03:07.571284: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:43] Reading SavedModel from: /tmp/vit_b32_fe/
2022-09-16 09:03:07.603759: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:107] Reading meta graph with tags { serve }
2022-09-16 09:03:07.603788: I external/org_tensorflow/tensorflow/cc/saved_model/reader.cc:148] Reading SavedModel debug info (if present) from: /tmp/vit_b32_fe/
2022-09-16 09:03:07.720411: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:228] Restoring SavedModel bundle.
2022-09-16 09:03:08.258917: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:212] Running initialization op on SavedModel bundle at path: /tmp/vit_b32_fe/
2022-09-16 09:03:08.550772: I external/org_tensorflow/tensorflow/cc/saved_model/loader.cc:301] SavedModel load for tags { serve }; Status: success: OK. Took 979495 microseconds.
Java: Model with ConfigProto/disabled JIT, warm up took 31.632 seconds

BUILD SUCCESSFUL in 1m 25s
2 actionable tasks: 1 executed, 1 up-to-date
```
