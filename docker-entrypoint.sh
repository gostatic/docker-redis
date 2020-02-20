#!/bin/sh
set -e

echo "ENTRY"

MASTER_HOST=${REDIS_MASTER_HOST:-redis-master}
MASTER_PORT=${REDIS_MASTER_PORT:-6379}

echo "=> Setting master connection details in /usr/local/etc/redis/redis-slave.conf"
echo  "slaveof ${MASTER_HOST} ${MASTER_PORT}" >> /usr/local/etc/redis/redis-slave.conf

if [[ "$REDIS_MASTER_AUTH" != "" ]]; then
  echo "=> Using authentication for redis-master"
  echo "masterauth $REDIS_MASTER_AUTH" >> /usr/local/etc/redis/redis-slave.conf
fi

if [[ "$REDIS_PASS" != "" ]]; then
  echo "=> Securing redis-master with password"
  echo "requirepass $REDIS_PASS" >> /usr/local/etc/redis/redis-master.conf
  echo "requirepass $REDIS_PASS" >> /usr/local/etc/redis/redis-slave.conf
fi

exec "$@"
