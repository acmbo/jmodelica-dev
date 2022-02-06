
IMG_NAME = jmoddev

COMMAND_RUN=docker run \
	  --name ${IMG_NAME} \
	  --rm \
 	  -it \
	  -p 8888:8888
	  
#127.0.0.1:8000:8000

build:
	cd dockerfile && docker build --no-cache --rm -t ${IMG_NAME} .

run: 
	$(COMMAND_RUN) --detach=false ${IMG_NAME} /bin/bash

run-detached:
	$(COMMAND_RUN) --detach=true ${IMG_NAME} /bin/bash

run-jup:
	docker run \
	  --name ${IMG_NAME} \
	  --rm \
	  -it \
	  -p 8888:8888 ${IMG_NAME}

stop:
	docker stop ${IMG_NAME}
