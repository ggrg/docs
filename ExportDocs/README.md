# Exporting the Documentation
In Mojaloop, the source for the documentation are markdown files stored in GitHub. We use use a tool called [Dactyl](https://github.com/ripple/dactyl) to convert files to from markdown (md) format to PDF format. The PDF format is the exported format we use to share offline documentation.
Overview and cross-repo documentation is in the Docs repository. Other repositories have detailed information about their contents.

## Setup
See [Dactyl setup](https://github.com/ripple/dactyl) to setup the tool. Dactyl has dependencies on Python and on a command line tool Prince to do part of that conversion.

> git pull # the latest for all relevant repositories

All the repositories should be in the same root directory.

Because building the documentation requires md files from multiple repos, the latest files from all the repos mentioned in the dactyl-config file need to be obtained. The list of required repos may change, but currently includes all of the following:

	mojaloop
    central-directory
    central-ledger
    Docs
	ilp-service
    forensic-logging-sidecar
    interop-ilp-ledger
    interop-dfsp-directory
    

## Build Process

### Copy the image files
Images that are going to be included in the documentation need to be copied to a images directory. Run the script CopyImages.sh from the root directory (the one above docs)

> Docs/ExportDocs/CopyImages.sh

### Run Dactyl
From the root directory run the dactyl build command for the document. For example, to generate a full set of documents run:
> dactyl_build -t all -c Docs/ExportDocs/dactyl-config.yml --pdf

To generate just the stakeholder overview run:
> dactyl_build -t stakeholder -c Docs/ExportDocs/dactyl-config.yml --pdf

## Build Info
Dactyl first converts all the md files to HTML. In that process it can apply common css styles and cover pages which are in the pdf_templates directory. Prince is then used by Dactyl to convert the HTML files to PDF. The --leave_temp_files parameter can be very useful for debugging if you want to see the intermediate HTML.

The files are written to the "out" directory under the root.
