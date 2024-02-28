import argparse
import contextlib
import random
import numpy as np
import torch
import os
from gemma import config
from gemma import model as gemma_model

@contextlib.contextmanager
def _set_default_tensor_type(dtype: torch.dtype):
    """Sets the default torch dtype to the given dtype."""
    torch.set_default_dtype(dtype)
    yield
    torch.set_default_dtype(torch.float)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ckpt", type=str, default="/tmp/ckpt")
    parser.add_argument("--device",
                        type=str,
                        default="cpu",
                        choices=["cpu", "cuda"])
    parser.add_argument("--output_len", type=int, default=4)
    parser.add_argument("--seed", type=int, default=12345)
    parser.add_argument("--quant", action='store_true')
    args = parser.parse_args()

    # Construct the model config.
    model_config = config.get_model_config(os.getenv("variant"))
    model_config.dtype = "float32" if args.device == "cpu" else "float16"
    model_config.quant = args.quant

    # Seed random.
    random.seed(args.seed)
    np.random.seed(args.seed)
    torch.manual_seed(args.seed)

    # Create the model and load the weights.
    device = torch.device(args.device)
    with _set_default_tensor_type(model_config.get_dtype()):
        model = gemma_model.GemmaForCausalLM(model_config)
        model.load_weights(args.ckpt)
        model = model.to(device).eval()
    print("Model loading done")

    while True:
        print('======================================')
        prompt = input("Question: ")
        result = model.generate(prompt, device)
        print(f'RESULT: {result}')