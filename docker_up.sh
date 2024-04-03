DOCKER_URI=gemma:${USER}
VARIANT=7b
VERSION="-it"
CKPT_PATH=${DATA:-/opt/}Gemma/model/${VARIANT}${VERSION}/gemma-${VARIANT}${VERSION}.ckpt
OUTPUT_LENGTH=300

docker run -itd --rm -v ${CKPT_PATH}:/tmp/ckpt -e variant=${VARIANT} -e output_len=${OUTPUT_LENGTH} --name gemma ${DOCKER_URI} 