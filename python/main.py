import os
os.environ['TF_XLA_FLAGS'] = '--tf_xla_auto_jit=-1'
import tensorflow as tf
import tensorflow_hub as hub
from timeit import default_timer as timer

model_path = "/tmp/vit_b32_fe/"
print(f"Loading saved model from {model_path}")
inference_func = hub.KerasLayer(model_path)
# do warm up query
start = timer()
dummy_input = tf.constant(0.5, shape=(1, 224, 224, 3))
inference_func(dummy_input)
elapsed_seconds = timer() - start
print(f"Python: warm up without flags finished in {elapsed_seconds} seconds")

