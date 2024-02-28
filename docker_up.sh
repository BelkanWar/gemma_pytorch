DOCKER_URI=gemma:${USER}
VARIANT=7b
CKPT_PATH=${DATA}Gemma/model/${VARIANT}-it/gemma-${VARIANT}-it.ckpt

docker run -itd --rm -v ${CKPT_PATH}:/tmp/ckpt -e variant=${VARIANT} ${DOCKER_URI} 