SHELL=/bin/bash
IMAGE=10.254.0.50:5000/zookeeper:3.4
MANIFEST=./manifest

all: build push deploy

build:
	@docker build -t ${IMAGE} .

push:
	@docker push ${IMAGE}

deploy: OP=create
deploy:
	@kubectl ${OP} -f ${MANIFEST}/.

clean: OP=delete
clean:
	@kubectl ${OP} -f ${MANIFEST}/.

test:
	-@kubectl exec -it zoo1-0 -- zkServer.sh status
	-@kubectl exec -it zoo2-0 -- zkServer.sh status
	@kubectl exec -it zoo3-0 -- zkServer.sh status
