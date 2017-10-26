## As a Mule Developer ##

### Installation and Setup

#### Anypoint Studio
* [https://www.mulesoft.com/platform/studio](https://www.mulesoft.com/platform/studio)
* Clone https://github.com/Mojaloop/interop-spsp-clientproxy.git to local Git repository
* Import into Studio as a Maven-based Mule Project with pom.xml
* Go to Run -> Run As Configurations.  Make sure interop-spsp-clientproxy project is highlighted.

#### Standalone Mule ESB
* [https://developer.mulesoft.com/download-mule-esb-runtime](https://developer.mulesoft.com/download-mule-esb-runtime)
* Add the environment variable you are testing in (dev, prod, qa, etc).  Open <Mule Installation Directory>/conf/wrapper.conf and find the GC Settings section.  Here there will be a series of wrapper.java.additional.(n) properties.  create a new one after the last one where n=x (typically 14) and assign it the next number (i.e., wrapper.java.additional.15) and assign -DMULE_ENV=dev as its value (wrapper.java.additional.15=-DMULE_ENV=dev)
* Download the zipped project from Git
* Copy zipped file (Mule Archived Project) to <Mule Installation Directory>/apps

### Run Application

#### Anypoint Studio
* Run As Mule Application with Maven

#### Standalone Mule ESB
* CD to <Mule Installation Directory>/bin -> in terminal type ./mule

### Test Application

#### Anypoint Studio
* Run Unit Tests
* Test API with Anypoint Studio in APIKit Console
* Verify Responses in Studio Console output

#### Standalone Mule ESB
* Review Server Logs for Unit Test results
* Test API with Browser at [http://<host:port>/spsp/client/v1/console](http://localhost:8081/spsp/client/v1/console/)
* Test API with Postman at [http://<host:port>/](http://localhost:8081/spsp-clientproxy/v1/<resource,args>)
  * **Note**: make sure you have set the content type to application/json 
* Verify Responses in Server Logs <Mule Installation Directory>/logs/*.log
