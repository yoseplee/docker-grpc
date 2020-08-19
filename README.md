# docker-grpc
a simple example for grpc server on container and client code


# Build Server
## Local
```shell script
# docker-grpc/server/
$ go build .
```

## Container
```shell script
# docker-grpc/
$ docker build --tag helloworld:0.1 --build-arg PORT=50051 .
```

# Run Sever
## Local
```shell script
# docker-grpc/server/
$ go run .
```

## Container
```shell script
# anywhere
$ docker run -d -p 50051:50051 helloworld:0.1
```

# Run Client
```shell script
# docker-grpc/client/
$ go run .
```

