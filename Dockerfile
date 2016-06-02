FROM redis:3.0.7-alpine

COPY *.conf /usr/local/etc/redis/
COPY *.sh /usr/local/bin/

CMD ["redis-server"]
