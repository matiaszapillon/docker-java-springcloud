Creation of a Dockerfile which initializes a java environment container and runs a spring cloud program.


1 - run the java image with the following command: docker run -d -it --name javaContainer java-docker
2 - inspect the ip of the docker container: docker inspect javaContainer
3 - use curl to test the service: curl http://{ipDocker}:8761/actuator
