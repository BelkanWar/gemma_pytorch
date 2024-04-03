DOCKER_URI=gemma:${USER}
VARIANT=7b
VERSION="-it"
CKPT_PATH=${DATA:-/opt/}Gemma/model/${VARIANT}${VERSION}/gemma-${VARIANT}${VERSION}.ckpt
OUTPUT_LENGTH=300

PROMPT="what kind of company is novo nordisk? "

docker run -t --rm \
    -v ${CKPT_PATH}:/tmp/ckpt \
    ${DOCKER_URI} \
    python scripts/run.py \
    --ckpt=/tmp/ckpt \
    --variant="${VARIANT}" \
    --output_len="${OUTPUT_LENGTH}" \
    --prompt="${PROMPT}"