## CI (Continuous Integration) & CD (Continuous Deployment) Requirements

### 1. Continuous Integration Pipeline

- Currently working for Central-Ledger

- Workflow includes the following Steps: 
    - setup - configure and install pre-requisites for tests, and builds
    - test-unit - runs unit tests
    - test-coverage - runs coverage tests, produces lcov.info file and publishes the file to SonarQube
    - test-integration - runs integration tests by spinning up docker containers
    - test-functional - runs functional tests by spinning up docker containers
    - test-spec - runs specification tests against the Five Bells implementation *Note: current not working from the initial code migrated from L1P to Mojaloop Github org*
    - build-snapshot - builds and publishes Snapshot (dev release candidate) packages when a tag (format `v{major}.{minor}-snapshot`) is pushed with the following regex: 
        
``` REGEX
/v[0-9]+(\.[0-9]+)*\-snapshot/
```

- build- builds and publishes Release (prod) packages when a tag (format `v{major}.{minor}`) is pushed with the following regex: 


``` REGEX
/v[0-9]+(\.[0-9]+)*/
```
            

- Peer Reviews will kick off the following steps which is part of the PR checks:
    - setup
    - test-unit
    - test-coverage
    - test-integration
    - test-functional
- Commits to the "develop" and "master" branches will kick off the following flows:
    - setup
    - test-unit
    - test-coverage
    - test-integration
    - test-functional
- Publishing a Release via a Tag Push with the following format v{major}.{minor} kick off the following flows:
    - setup
    - test-unit
    - test-coverage
    - test-integration
    - test-functional
    - build
- Publishing a Snapshot via a Tag Push with the following format v{major}.{minor}-snapshot kick off the following flows:
    - setup
    - test-unit
    - test-coverage
    - test-integration
    - test-functional
    - build-snapshot

- Pending issues:
    - Bill raised a concern that hub.docker.com and npmjs.com repositories are being used, and wants to validate with Millar if we should continue with this approach or if a switch to JFrog is necessary. <-- There has been some confusion as to what the "status quo" means from the London meeting, but my understanding is that it means using hub.docker.com and npmjs.com as that has already been implemented (prior to the London meeting - by manual deployments).

### 2. Continuous Deployment Pipeline

- Publishing a Snapshot via a Tag Push with the following format `v{major}.{minor}-snapshot` will deploy into the following namespace "mojaloop-snapshot" 
- If there is no "dev" release within that namespace a new deployment will occur
- If there is an existing "dev" release within that namespace the existing "dev" release will be upgraded
- Publishing a Release via a Tag Push with the following format `v{major}.{minor}` will deploy into the following namespace "mojaloop-release" 
-   If there is no "prod" release within that namespace a new deployment will occur
- If there is an existing  "prod" release within that namespace the existing  "prod" release will be upgraded
