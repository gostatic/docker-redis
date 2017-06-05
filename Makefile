build:
	docker build -t containerdb/redis:latest .
	docker build -t containerdb/redis:3.2.9-alpine .

run-slave:
	docker run -ti --env-file .env -v /tmp/containerdb-redis-slave:/data -a STDIN -a STDOUT -p 26379:6379 --rm containerdb/redis redis-server /usr/local/etc/redis/redis-slave.conf
run-slave-shell:
	docker run -ti --env-file .env -v /tmp/containerdb-redis-slave:/data -a STDIN -a STDOUT --rm containerdb/redis sh

run-master:
	docker run -ti --env-file .env -v /tmp/containerdb-redis-master:/data -a STDIN -a STDOUT -p 16379:6379 --rm containerdb/redis redis-server /usr/local/etc/redis/redis-master.conf

push:
	docker push containerdb/redis:latest
	docker push containerdb/redis:3.2.9-alpine
