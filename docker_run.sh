DOCKER_URI=gemma:${USER}
VARIANT=2b
CKPT_PATH=${DATA}Gemma/model/${VARIANT}-it/gemma-${VARIANT}-it.ckpt
PROMPT="where is Taiwan"

docker run -t --rm \
    -v ${CKPT_PATH}:/tmp/ckpt \
    ${DOCKER_URI} \
    python scripts/run.py \
    --ckpt=/tmp/ckpt \
    --variant="${VARIANT}" \
    --prompt="${PROMPT}"