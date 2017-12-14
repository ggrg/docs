# Exporting the Documentation
In Mojaloop, the source for the documentation are markdown files stored in GitHub. We use use a tool called [Dactyl](https://github.com/ripple/dactyl) to convert files to from markdown (md) format to PDF format. The PDF format is the exported format we use to share offline documentation.
Overview and cross-repo documentation is in the Docs repository. Other repositories have detailed information about their contents.

## Setup
See [Dactyl setup](https://github.com/ripple/dactyl) to setup the tool. Dactyl has dependencies on Python and on a command line tool [Prince](http://princexml.com/) to do part of that conversion.

All the repositories should be in the same root directory.

Because building the documentation requires md files from multiple repos, you need to pull the latest files from all the repos mentioned in the dactyl-config file. The list of required repos may change, but currently includes all of the following:

- [mojaloop](https://github.com/mojaloop/mojaloop)
- [central-directory](https://github.com/mojaloop/central-directory)
- [central-fraud-sharing](https://github.com/mojaloop/central-fraud-sharing)
- [central-ledger](https://github.com/mojaloop/central-ledger)
- [docs](https://github.com/mojaloop/docs) (this repository)
- [ilp-service](https://github.com/mojaloop/ilp-service)
- [forensic-logging-sidecar](https://github.com/mojaloop/forensic-logging-sidecar)
- [interop-ilp-ledger](https://github.com/mojaloop/interop-ilp-ledger)
- [interop-dfsp-directory](https://github.com/mojaloop/interop-dfsp-directory)

You can use the following script to clone all of the needed repositories:

```
for repo in mojaloop central-directory central-fraud-sharing central-ledger docs ilp-service forensic-logging-sidecar interop-ilp-ledger interop-dfsp-directory; do git clone git@github.com:mojaloop/"$repo".git; done
```

Later, you can update all the repositories to the latest with the following:

```
for repo in mojaloop central-directory central-fraud-sharing central-ledger docs ilp-service forensic-logging-sidecar interop-ilp-ledger interop-dfsp-directory; do cd "$repo"; git pull; cd ..; done
```


## Build Process

### Copy the image files
Images that are going to be included in the documentation need to be copied to a images directory. Run the script CopyImages.sh from the root directory (the one above docs)

```
$ ./docs/ExportDocs/CopyImages.sh
```

### Run Dactyl
From the root directory run the dactyl build command for the document. For example, to generate a full set of documents run:
```
$ dactyl_build -t all -c docs/ExportDocs/dactyl-config.yml --pdf
```

To generate just the stakeholder overview run:
```
$ dactyl_build -t stakeholder -c docs/ExportDocs/dactyl-config.yml --pdf
```

## Build Info
Dactyl first converts all the md files to HTML. In that process it can apply common css styles and cover pages which are in the `pdf_templates` directory. Dactyl uses [Prince](http://princexml.com/) to convert the HTML files to PDF. The `--leave_temp_files` parameter can be very useful for debugging if you want to see the intermediate HTML.

The files are written to the `out/` directory under the root.
