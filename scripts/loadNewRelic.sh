#!/bin/bash
insights_app_id=1451752
insights_api_key=C4ruIzD1qmJouq_50Pf3bB3DQjQDYski


# Load a JSON file using curl
cat $1 | curl -d @- -X POST \
 -H "Content-Type: application/json" \
 -H "X-Insert-Key: $insights_api_key" \
  https://insights-collector.newrelic.com/v1/accounts/$insights_app_id/events