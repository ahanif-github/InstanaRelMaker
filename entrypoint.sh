#!/bin/sh -le

echo "Creating release $1"

echo "${2}" > scope.json

res=$(curl --location --request POST "${INSTANA_BASE}/api/releases" \
  --silent \
  --fail \
  --show-error \
  --header "Authorization: apiToken ${INSTANA_TOKEN}" \
  --header "Content-Type: application/json" \
  --user-agent "ahanif-github/InstnaRelMaker/${version:-dev}" \
  --data "{
	\"name\": \"${1}\",
	\"start\": $(date +%s)000,
  	\"applications\": [
      {
        \"name\": \"${INSTANA_APPLICATION}\" 
      }
}")

echo $res

id=$(echo "$res" | jq ".id" -r)

echo ::set-output name=id::$id
