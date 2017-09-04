
 #!/bin/bash

 login_host=https://login.salesforce.com

 if [ $3 = sandbox ]
 	then
 	login_host="https://test.salesforce.com"
 fi

 echo $login_host

 #Login using the Login FrontDoor url and obtain an OAuth Access Token using the Username-password flow
 curl --trace login.trace $login_host/services/oauth2/token -d "grant_type=password"  \
-d "client_id=3MVG9szVa2RxsqBZmrwGtrrMHcbeZ821nO_WSekA2xQPA0IadOwH_7NTiSxjTbcPCaXsLMfF9_n151mG2sc86" \
-d "client_secret=4071089317208316339" \
-d "username=$1" \
-d "password=$2" > access_token.json 

access_token=`cat access_token.json | jq -r .access_token`

if [ $access_token != 'null' ] ; then
	echo access_token.json

	#cat access_token.json | jq -r .token_type 

	instance_url=`cat access_token.json | jq -r .instance_url`

	echo "Access Token " $access_token
	echo "Instance Url" $instance_url
else
	echo "Failed to authenticate"
	echo "Message: " `cat access_token.json | jq -r .error_description`
	exit 1
fi



# Simple demo api call that will always work
curl $instance_url/services/data/v39.0/query?q=SELECT+Id+,+Name+FROM+Account+LIMIT+100  \
 -H "Authorization: Bearer $access_token" \
 -H 'Content-Type: application/json' \
 -H "X-PrettyPrint:1" \
 -o ./accounts.csv

# This call lists Event log records
 curl $instance_url/services/data/v39.0/query?q=SELECT+Id,+EventType,+LogFile,+LogDate+From+EventLogFile \
 -H "Authorization: Bearer $access_token" \
 -H 'Content-Type: application/json' \
 -H "X-PrettyPrint:1" \
 -o ./eventlogs.json

# Download all of the Event Log file
# The jq command extracts all of the logfile ids from the prior response

logfile_ids=`cat eventlogs.json | jq -r '.records | map(.Id) | join(" ")'`

for current in $logfile_ids
do
	logfile_name="$current.csv"
	logfile_endpoint="/services/data/v39.0/sobjects/EventLogFile/$current/LogFile"
	echo "ID: " $current
	echo "Logfile Name: " $logfile_name
	echo "Logfile endpoint: " $logfile_endpoint
	echo "Downloading now"
	curl $instance_url$logfile_endpoint -H "Authorization: Bearer $access_token" -H "X-PrettyPrint:1" -o $logfile_name
done




