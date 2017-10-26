# Setting up the Development Environment

## Install development tools

### Install Visual Studio Code editor

Download and install VS Code from [Download Visual Studio Code](https://code.visualstudio.com/Download).

### Install Node.js platform

Download and install lastest stable version of Node.js from [Node.js downloads](https://nodejs.org/en/download/).
Check the version by typing `node -v` in the console. It should be at least 4.5.0.

### Update npm package manager

Node comes with npm installed. Update to the lastest version with the command `npm install npm -g`. Check the version of npm with the command `npm -v`. It should be higher than 3.10.

### Install git

Install git as appropriate place for your operating system.

## Clone the project

Generate and add SSH key to github. If you are not sure how to do that, you can follow the guides here [Generate an SSH key](https://help.github.com/articles/generating-an-ssh-key/)
Navigate to the directory where the project should be cloned and type in the console for example:

```bash
git clone git@github.com:LevelOneProject/dfsp-directory.git
```

## Configuration file for the database

Create configuration file named .ut_dfsp_directory_devrc in the home directory (C:/Users/[username]) that contains the individual access settings for the database. The content of the file should be the following:

```ini
[db.db]
database=dfsp-directory-<name>-<surname>
user=<name>.<surname>
password=<password>

[db.create]
user=<admin user>
password=<admin password>
```

The common settings can be found in the dev.json file in the server directory of the project.

## Run npm install

In the project diectory (dfsp-directory) run `run npm install`.

## Launch Configurations

Debugging in VS Code requires launch configuration file - `launch.json`. To create it click on the Configure gear icon on the Debug view top bar, choose debug environment and VS Code will generate a launch.json file under workspace's .vscode directory.
Generated for Node.js debugging launch.json should look like the following:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "directory",
            "type": "node",
            "request": "launch",
            "program": "${workspaceRoot}/index.js",
            "stopOnEntry": false,
            "args": [],
            "cwd": "${workspaceRoot}",
            "preLaunchTask": null,
            "runtimeExecutable": null,
            "runtimeArgs": [
                "--nolazy"
            ],
            "env": {
                "NODE_ENV": "development"
            },
            "externalConsole": false,
            "sourceMaps": false,
            "outDir": null
        }
    ]
}
```

* `name`: name of configuration; appears in the launch configuration drop down menu
* `type`: type of configuration; possible values: "node", "mono"
* `program`: wrkspace relative or absolute path to the program
* `stopOnEntry`: automatically stop program after launch
* `args`: command line arguments passed to the program
* `cwd`: workspace relative or absolute path to the working directory of the program being debugged. Default is the current workspace
* `runtimeExecutable`: workspace relative or absolute path to the runtime executable to be used. Default is the runtime executable on the PATH
* `runtimeArgs`: optional arguments passed to the runtime executable
* `env`: environment variables passed to the program
* `sourceMaps`: use JavaScript source maps (if they exist)
* `outDir`: if JavaScript source maps are enabled, the generated code is expected in this directory

## Required Extensions for VS Code

In VS Code press `ctrl` + `shift` + `p` and type in the new open input field Install Extensions, or press `ctrl` + `shift` + `x` to go directly to the extensions.

### beautify

Find `beautify` in the Extensions marketplace, install and enable it. This extension enables running js-beautify in VS Code. The generated .jsbeautifyrc loads code styling. It should has the following settings:

```json
{
  "end_with_newline": true,
  "wrap_line_length": 160,
  "e4x": true,
  "jslint_happy": true,
  "indent_size": 2
}
```

Formatting code can be done with `Shift` + `Alt` + `F`.

### CircleCl

Find `CircleCl` in the Extensions marketplace and install it. To enable it go to [CircleCI](https://circleci.com/account/api) and create an API token. Add it as `circleci.apiKey` in the Workspace Settings in VS Code (File -> Preferences -> Workspace Settings):

```json
{
    "circleci.apiKey": [API token]
}
```

### ESLint

This extension contributes the following variables to the Default settings of VS Code:

```json
"eslint.enable": true,
"eslint.options": {}
```

* `eslint.enable`: enabled by default
* `eslint.options`: options to configure how eslint is started. They can be specified as valid for all projects in the User Settings (File -> Preferences -> User Settings) or only for a project in the Workspace Settings (File -> Preferences -> Workspace Settings) in which case the User Settings will be overwritten.

Each project includes the module ut-tools as developmen dependency. You need to point eslint config file to the eslint settings used.

#### Example

```json
{
    "eslint.options": {
        "configFile": "/[path-to-project]/node_modules/ut-tools/eslint/l1p.eslintrc"
    }
}
```
