
#Counts the non-blank, non-comment lines for all the config files in the repo (yml, SQL, xml, json, template, sh, properties, Dockerfile)
function SumAllFiles()
{
	OIFS="$IFS"
	IFS=$'\n'
	cd $1
	Total=0
	for filename in $(find . -type f -iregex  '.*\(yml\|sql\|xml\|json\|template\|sh\|properties\|Dockerfile\)$' -not -path "*.git*" -not -path "*node_modules*"); do
		#echo $filename
		count=$(egrep -cv '#|^$' "$filename")
		Total=$(($Total+$count))		
	done
	cd ..
	echo $Total
}

#echo interop-docker: $(SumAllFiles interop-docker)

#lists the config file counts for all the subdirectories
#run from root directory containing all repos
function ListAllDirectories()
{
	for directory in $(find -maxdepth 1 -type d -not -path "."); do
		lines=$(SumAllFiles $directory)
		echo $directory: $lines
	done
}

ListAllDirectories