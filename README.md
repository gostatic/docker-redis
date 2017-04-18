# Docker Image: gostatic/redis

The main purpose of this image is to support password protected master/slave redis with minimal configuration.


## Configuration

### Master

```
REDIS_PASS # This is the password required to authenticate against the server.
```

### Slave

The slave must be linked to a container called `redis-master` exposed via port
6379. This is currently a hard coded limitation.

```
REDIS_MASTERAUTH # Password to use when connecting to redis://redis-master:6379
```
