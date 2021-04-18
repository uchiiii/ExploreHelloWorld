
.PHONY: dbuild
dbuild:
	docker build -t ubuntu32 . 

.PHONY: run
run:
	docker run --name hello_ubuntu32 \
	--rm -it \
	-v $${HOME}/tmp/understand_hello_world_32/:/home/user/hello_world \
	-v ~/.vimrc:/root/.vimrc \
	ubuntu32

.PHONY: enter
enter:
	docker exec -it hello_ubuntu32 bash