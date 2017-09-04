# ShieldEVT
Shield Event Log Extract, Transform, and Load scripts using CURL

Scripts are written as BASH scripts

Depends on JQ utility to manipulate JSON results.
https://stedolan.github.io/jq/

Depends on EventLogConverter Java utility to transform the eventlogs themselves to make them compatible with New Relic
For convenience, the Jar is included with this project, but source can be found here:
https://github.com/bobbywhitesfdc/EventLogConverter

<h2>Running</h2>
It's broken into 3 stages:
<ul>
<li>Extract</li>
<li>Transform</li>
<li>Load</li>
</ul>

<h3>Extract</h3>
This uses curl to connect to Salesforce, query the logs, and extract their contents.

<em>./extractEventLogs.sh username password [sandbox]</em>

<h3>Transform</h3>
Converts the CSV files to JSON

<em>./transformAll.sh</em>

<h3>Load</h3>
Loads to New Relic
<em>./load.sh</em>

You'll need to update this script to use your ID and API_KEY
insights_app_id={yourID}
insights_api_key={yourAPI_KEY}

