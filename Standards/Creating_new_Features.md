## Creating new Features ##

### Fork ###

Fork the Mojaloop repository into your own personal space.
Ensure that you keep the `master` branch in sync.

Refer to the following documentation for more information: https://help.github.com/articles/fork-a-repo/

1. Clone repo using Git Fork button (refer to the above documentation for more information)

2. Clone your forked repo: `git clone https://github.com/<your_username>/<forked_repo>.git`

3. Synchronise your forked repo with Mojaloop
    
     Add a new upstream repo for Mojaloop `$ git remote add mojaloop https://github.com/mojaloop/<original_repo>.git`

    You should now see that you have two remotes:
    ```bash
    git remote -v
    origin    https://github.com/<your_username>/<forked_repo>.git (fetch)
    origin    https://github.com/<your_username>/<forked_repo>.git (push)
    mojaloop  https://github.com/mojaloop/<original_repo>.git (fetch)
    mojaloop  https://github.com/mojaloop/<original_repo>.git (push)
    ```
4. To sync to your current branch: `git pull mojaloop <current_branch>`
    This will merge any changes from Mojaloop's repo into your forked repo.

5. Push the changes back to your remote fork: `git push origin <current_branch>`

### Feature Branch ###

Create a new feature branch from the `master` branch with the following format:
<issue#><issueDescription> where `issue#` can be attained from the Github issue, and the `issueDescription` is the formatted in CamelCase.

1. Create and checkout the branch: `git checkout -b [name_of_your_new_branch]` 
2. Push the branch to your remote: `git push origin [name_of_your_new_branch]`

### Merge into Mojaloop Repo ###

Once the feature is completed create a PR from your Feature Branch into the `master` branch on the Mojaloop repository (not your personal repo) for approval, and check validations (e.g. unit tests, code coverage, etc executed via CircieCI).
