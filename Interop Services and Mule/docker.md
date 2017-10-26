# Mule's Docker Image
This docker image is based on Java's official docker image.

Applications are incorporated into the image, which is why we need to change the dockerfile in order to do a COPY command to copy the zip file into mule's applications folder: "/opt/mule/apps"

Mule folders for domains, configs and logs are mounted volumes so those can be mapped to host directories.

## Building it

### Parameters
There are two different parameters to build, one is the version and the other is the port that is exposed. In case a parameter is missing then the defaults are 3.8.0 for version and 8081 for ports.
The versions that are supported are: 3.8.0, 3.7.0, 3.6.1, 3.6.0 and 3.5.0

### Command

In order to build, the following command is used replacing the <<>> with the actual values:

```docker build -t <<userName>>/<<imageName>>:<<tag>> -f <<dockerFileName>> <<dockerBuildPath>>```

username is only required if the image needs to be pushed to docker hub.
If dockerfile is named "Dockerfile" then there is no need to specify the -f <<dockerFileName>> argument.
Mule's application zip should be saved into dockerBuildPath.

### Final output
After this command is run, a mule image that is ready to be instantiated into a container is created.

### Running a container from the image created

The following command starts and runs a container:

```docker run -d -p 8081:8081 -v <<hostFolder>>:<<containerVolumeFolder>> --name <<containerName>> <<imageUserName>>/<<imageName>>:<<imageTag>>```

-d is indicating that it will run as a daemon.
-v is used to map a hostFolder to a container's volume.
"imageUserName:/"imageName":"imageTag" is mandatory and specifies which image to use for the new container.

#### Example

```docker run -d -p 8081:8081 -v ~/hostMuleLogs:/opt/mule/logs --name myMuleContainer modusbox/mule:latest```

The following command can be used to log into a container:

```docker exec -ti <<containerName>> bash```
