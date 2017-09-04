#!/bin/bash
# Script to Transform Shield EventLog CSV files into JSON that can be loaded into NEW Relic
# Author: Bobby White
# Company: Salesforce.com
# Date:  August 27, 2017
# Email: bobby.white@salesforce.com
#
# This script assumes that all files in the current directory need to be transformed
# REQUIRES the package d3-dsv to have been installed
# @See: https://github.com/stedolan/jq/wiki/Cookbook#convert-a-csv-file-with-headers-to-json

for filename in *.csv; do
	echo "Input Filename: "  $filename

	outputFilename=${filename%.*}.json
	echo "Output Filename: " $outputFilename

 # EventLogConverter renames one of the header fields and adds a timestamp that is compatible with New Relic
    java -jar ./EventLogConverter-1.0.jar	-i $filename | csv2json > $outputFilename

done
