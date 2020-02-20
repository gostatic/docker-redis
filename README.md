# Docker Image: gostatic/redis

The main purpose of this image is to support password protected master/slave Redis with minimal configuration.

## Versions

Not all upstream versions are supported. We only tend to support Ubuntu (for compatibility) and Alpine (small image size).

- 3.2.11
- 3.2.11-alpine
- 4.0.14
- 4.0.14-alpine


## Configuration

### Master

```
REDIS_PASS # This is the password required to authenticate against the server.
```

Default is to run in master mode

```
docker run -t -e REDIS_PASS=masterpass -p 6379:6379 gostatic/redis
```

### Slave

The slave must be linked to a container called `redis-master` exposed via port
6379. This is currently a hard coded limitation.

```
REDIS_MASTERAUTH # Password to use when connecting to redis://redis-master:6379
```

In order to activate "slave mode", pass in the config path at runtime:

```
docker run -t -e REDIS_PASS=slavepass -e REDIS_MASTERAUTH=masterpass -p 6379:6379 gostatic/redis redis-server /usr/local/etc/redis/redis-slave.conf
```
