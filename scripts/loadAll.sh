#!/bin/bash
# Script to load all JSON files in the current directory into NEW Relic
#
# Author: Bobby White
# Company: Salesforce.com
# email: bobby.white@salesforce.com
# Date:  August 27, 2017

# The following keys are specific to the New Relic Instance
insights_app_id=1451752
insights_api_key=C4ruIzD1qmJouq_50Pf3bB3DQjQDYski

for filename in *.json; do
	echo "Loading Filename: "  $filename
	outputFilename=${filename%.*}.result
	echo "Output Filename: " $outputFilename


	# Load a JSON file using curl
	cat $filename | curl -d @- -X POST \
	 -H "Content-Type: application/json" \
 	 -H "X-Insert-Key: $insights_api_key" \
  https://insights-collector.newrelic.com/v1/accounts/$insights_app_id/events > $outputFilename


  	echo "Done loading"
  	echo < $outputFilename
done
