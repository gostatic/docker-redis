#!/bin/sh
set -e

echo "ENTRY"

if [[ "$REDIS_MASTERAUTH" != "" ]]; then
  echo "=> Using authentication for redis-master"
  echo "masterauth $REDIS_MASTERAUTH" >> /usr/local/etc/redis/redis-slave.conf
fi

if [[ "$REDIS_PASS" != "" ]]; then
  echo "=> Securing redis-master with password"
  echo "requirepass $REDIS_PASS" >> /usr/local/etc/redis/redis-master.conf
  echo "requirepass $REDIS_PASS" >> /usr/local/etc/redis/redis-slave.conf
fi

exec "$@"
