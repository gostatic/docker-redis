build:
	docker build -t gostatic/redis .

run-slave:
	docker run -ti --env-file .env -v /tmp/gostatic-redis-slave:/data -a STDIN -a STDOUT -p 26379:6379 --rm gostatic/redis redis-server /usr/local/etc/redis/redis-slave.conf
run-slave-shell:
	docker run -ti --env-file .env -v /tmp/gostatic-redis-slave:/data -a STDIN -a STDOUT --rm gostatic/redis sh

run-master:
	docker run -ti --env-file .env -v /tmp/gostatic-redis-master:/data -a STDIN -a STDOUT -p 16379:6379 --rm gostatic/redis redis-server /usr/local/etc/redis/redis-master.conf

push:
	docker push gostatic/redis
