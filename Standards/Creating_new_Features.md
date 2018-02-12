## Creating new Features ##

### Fork ###

Fork the Mojaloop repository into your own personal space.
Ensure that you keep the `develop` and `master` branches in sync.

### Feature Branch ###

Create a new feature branch from the `develop` branch with the following format:
<issue#><issueDescription> where `issue#` can be attained from the Github issue, and the `issueDescription` is the formatted in CamelCase.

### Merge into Mojaloop Repo ###

Once the feature is completed create a PR from your Feature Branch into the `develop` branch on the Mojaloop repository (not your personal repo) for approval, and check validations (e.g. unit tests, code coverage, etc executed via CircieCI).
