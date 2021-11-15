.PHONY: all shell

TAG	:= kamakas/websvr-access-test

all: Dockerfile
	docker build -f $< -t $(TAG) .

run:
	docker run -d -p 8000:80 -p 8001:81 $(TAG)

kill:
	docker kill `docker container ls -f ancestor=$(TAG) --format "{{.ID}}"`

shell:
	docker exec -it `docker container ls -f ancestor=$(TAG) --format "{{.ID}}"` /bin/bash

shelltmp:
	docker run --rm -it $(TAG) /bin/bash

