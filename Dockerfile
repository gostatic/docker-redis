FROM redis:3.2.8-alpine

COPY *.conf /usr/local/etc/redis/
COPY *.sh /usr/local/bin/

CMD ["redis-server", "/usr/local/etc/redis/redis-master.conf"]
