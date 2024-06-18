DOCKER_URI=gemma:${USER}
VARIANT=7b
VERSION=-it
ifeq ($DATA, "")
	CKPT_PATH=/opt/Gemma/model/${VARIANT}${VERSION}/gemma-${VARIANT}${VERSION}.ckpt
else
	CKPT_PATH=${DATA}Gemma/model/${VARIANT}${VERSION}/gemma-${VARIANT}${VERSION}.ckpt
endif
OUTPUT_LENGTH=300

PROMPT="what kind of company is novo nordisk?"

build ::
	docker build -f docker/Dockerfile -t ${DOCKER_URI} .

container-run ::
	docker run -t --rm \
		-v ${CKPT_PATH}:/tmp/ckpt \
		${DOCKER_URI} \
		python scripts/run.py \
		--ckpt=/tmp/ckpt \
		--variant=${VARIANT} \
		--output_len=${OUTPUT_LENGTH} \
		--prompt=${PROMPT}

container-up ::
	docker run -itd --rm -v ${CKPT_PATH}:/tmp/ckpt -e variant=${VARIANT} -e output_len=${OUTPUT_LENGTH} --name gemma ${DOCKER_URI}

container-down ::
	docker stop
