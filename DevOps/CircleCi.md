# CircleCI Mojaloop Configuration

## Prerequisites

### Setup Org Context for Mojaloop

The following Environment Variables are to be configured in CircleCI's defalt Org Context: `org-global`
| Variable | Description | Format/Value |
| --- | --- | --- |
| NPM_TOKEN | Auth Token for npmjs.com | string |
| DOCKER_ORG | Docker Org Name | 'mojaloop' |
| DOCKER_USER | Docker hub user name | string |
| DOCKER_PASS | Docker hub user password| string |
| K8_USER_NAME | Kubernetes user name | string |
| K8_CLUSTER_NAME | Kubernetes cluster name | string |
| K8_CLUSTER_SERVER | Kubernetes API Server URI | http://\<ip>:\<port> or https://\<ip>:\<port> |
| K8_USER_PEM_KEY_FILENAME | Name of Kubernetes PEM Key file stored in $AWS_S3_URI_DEVOPS_DEPLOYMENT_CONFIG | string |
| K8_USER_PEM_CERT_FILENAME | Name of Kubernetes PEM Cert file stored in $AWS_S3_URI_DEVOPS_DEPLOYMENT_CONFIG | string |
| K8_HELM_CHART_NAME | Name of Helm chart to be installed/upgraded | 'mojaloop' |
| K8_NAMESPACE_SNAPSHOT | Namespace for Snapshot deployments within Kubernetes | 'mojaloop-snapshot' |
| K8_NAMESPACE | Namespace for Snapshot deployments within Kubernetes | 'mojaloop-master' |
| K8_RELEASE_NAME_SNAPSHOT | Helm release name for Snapshot deployments within Kubernetes | 'dev' |
| K8_RELEASE_NAME | Helm release name for Snapshot deployments within Kubernetes | 'prod' |
| K8_HELM_REPO | Helm chart repository | 'http://mojaloop.io/helm/repo' |
| K8_HELM_VALUE_DEV_FILENAME | Helm chart value falue for Snapshot release | 'config-mojaloop-dev.yaml' |
| K8_HELM_VALUE_PROD_FILENAME | Helm chart value falue for release | 'config-mojaloop-prod.yaml' |
| AWS_ACCESS_KEY_ID | AWS Access Key ID | string |
| AWS_SECRET_ACCESS_KEY | AWS Access Key | string |
| AWS_S3_DIR_SONARQUBE | AWS S3 Bucket storing Deployment pre-requisite files | s3://\<bucket>/\<folder> |
| AWS_S3_URI_DEVOPS_DEPLOYMENT_CONFIG | AWS S3 Bucket storing Deployment pre-requisite files | s3://\<bucket> | 
| AWS_S3_DIR_DEVOPS_DEPLOYMENT_CONFIG_KEYS | AWS S3 Folder storing Deployment for K8 keys | 'k8-keys' |
| AWS_S3_DIR_DEVOPS_DEPLOYMENT_CONFIG_HELM | AWS S3 Folder storing Deployment configs | 'helm' |
| RELEASE_TAG_SNAPSHOT | Container tag for latest Snapshot release name | 'snapshot' |
| RELEASE_TAG | Container tag for latest release name | 'latest' |

## Create config.yml file

CircleCI v2.0 uses a file called `.circleci/config.yml` in every project in order to know how to work with it. Add a new file into the project folder `.circleci` within the project and name it `config.yml`. 

Refer to the following link for CircleCI v2.0 documentation: https://circleci.com/docs/2.0/


## CircleCI v2.0 config.yml

The following jobs must be created for all CircleCI v2.0 enabled Project:

### Jobs

#### 1. setup

##### 1.1. purpose
In this section all common pre-requisites are to be executed. In a NodeJs project for example we download all the dependencies via a `npm install` command, and store it in a re-usable cache that can be accessed by the subsequant jobs.

##### 1.2. dependencies
None

#### 2. test-unit

##### 2.1. purpose
In this section all Unit Tests must be excecuted. The results are to be stored in CircleCI's artifact repository for later access and review (if required).

##### 2.2. dependencies 
- setup

#### 3. test-coverage 

##### 3.1. purpose 
In this section Test Coverage for the code must be excecuted. The results are to be stored in CircleCI's artifact repository for later access and review (if required). In addition if the branch is "master" that the task is being executed against the resulting lcov.info file must be sent to SonarQube for reporting.

##### 3.2. dependencies 
- setup

#### 4. test-integration 

##### 4.1. purpose 
In this section Integration Tests for the code must be excecuted. The results are to be stored in CircleCI's artifact repository for later access and review (if required). 

##### 4.2. dependencies 
- setup

#### 5. test-functional 

##### 5.1. purpose
In this section Functional Tests for the code must be excecuted. The results are to be stored in CircleCI's artifact repository for later access and review (if required). 

##### 5.2. dependencies 
- setup

#### 6. build-snapshot  

##### 6.1. purpose 
In this section all artifacts for the project are build, and published as required. An example is that if a Docker image is the artefact, it will be build and published to the Docker repository if and only if the CircleCI event is triggered by a tag being pushed.

The tag is pushed with the following format:
- `v<major-verion>.<minor-version>-snapshot` <- build & publish a release candidate

##### 6.2. dependencies 
- setup
- test-unit
- test-coverage
- test-integration
- test-functional

#### 7. build 

##### 7.1. purpose 
In this section all artifacts for the project are build, and published as required. An example is that if a Docker image is the artefact, it will be build and published to the Docker repository if and only if the CircleCI event is triggered by a tag being pushed.

The tag is pushed with the following format:
- `v<major-verion>.<minor-version>` <- build & publish a release

##### 7.2. dependencies 
- setup
- test-unit
- test-coverage
- test-integration
- test-functional

#### 8. deploy-snapshot 

##### 8.1. purpose 
In this section the artifacts for the project that have been build by the `build-snapshot` job must be deployed to the `snapshot` environment if and only if the CircleCI event is triggered by a tag being pushed.

The tag is pushed with the following format:
- `v<major-verion>.<minor-version>-snapshot` <- deploy a candidate release

##### 8.2. dependencies 
- build-snapshot

#### 9. deploy 

##### 9.1. purpose 
In this section the artifacts for the project that have been build by the `build-snapshot` job must be deployed to the `snapshot` environment if and only if the CircleCI event is triggered by a tag being pushed.

The tag is pushed with the following format:
- `v<major-verion>.<minor-version>` <- deploy a release

##### 9.2. dependencies 
- build-snapshot

### Workflows

The following snippet must be used to defined your Workflows within the `config.yml` once the jobs have been created.

``` yml
workflows:
  version: 2
  build_and_test:
    jobs:
      - setup:
          context: org-global
          filters:
            tags:
              only: /.*/
            branches:
              ignore: 
                - /feature*/
                - /bugfix*/
      - test-unit:
          context: org-global
          requires:
            - setup
          filters:
            tags:
              only: /.*/
            branches:
              ignore: 
                - /feature*/
                - /bugfix*/             
      - test-coverage:
          context: org-global
          requires:
            - setup
          filters:
            tags:
              only: /.*/
            branches:
              ignore: 
                - /feature*/
                - /bugfix*/
      - test-integration:
          context: org-global
          requires:
            - setup
          filters:
            tags:
              only: /.*/
            branches:
              ignore: 
                - /feature*/
                - /bugfix*/
      - test-functional:
          context: org-global
          requires:
            - setup
          filters:
            tags:
              only: /.*/
            branches:
              ignore: 
                - /feature*/
                - /bugfix*/
      - build-snapshot:
          context: org-global
          requires:
            - setup
            - test-unit
            - test-coverage
            - test-integration
            - test-functional
          filters:
            tags:
              only: /v[0-9]+(\.[0-9]+)*\-snapshot/
            branches:
              ignore: 
                - /.*/
      - deploy-snapshot:
          context: org-global
          requires:
            - build-snapshot
          filters:
            tags:
              only: /v[0-9]+(\.[0-9]+)*\-snapshot/
            branches:
              ignore: 
                - /.*/
      - build:
          context: org-global
          requires:
            - setup
            - test-unit
            - test-coverage
            - test-integration
            - test-functional
          filters:
            tags:
              only: /v[0-9]+(\.[0-9]+)*/
            branches:
              ignore: 
                - /.*/
      - deploy:
          context: org-global
          requires:
            - build
          filters:
            tags:
              only: /v[0-9]+(\.[0-9]+)*/
            branches:
              ignore: 
                - /.*/
```

## Setting Slack Chat Notifications ###

TBD

## Rebuild ###

When you added the project for the first time the project build should have failed because there were no credentials provided in the environment variables. Once you finished the configuration get back to the dashboard and click on Rebuild so it can build the project again.

