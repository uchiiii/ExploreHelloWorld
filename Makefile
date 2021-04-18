
.PHONY: dbuild
dbuild:
	docker build -t ubuntu32 . 

.PHONY: run
run:
	docker run --rm -it -v $${HOME}/tmp/understand_hello_world_32/:/home/user/hello_world ubuntu32

.PHONY: enter
enter:
	docker exec -it 35fb2972d8eb bash