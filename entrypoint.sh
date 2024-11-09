#!/bin/sh -le

echo "Creating release $1"

echo "${2}" > scope.json

res=$(curl --location --request POST "https://ams-globelife.instana.io/api/releases" \
  --silent \
  --fail \
  --show-error \
  --header "Authorization: apiToken VQw6Xr_YS2C44vE2wjRWfA" \
  --header "Content-Type: application/json" \
  --user-agent "ahanif-github/InstnaRelMaker/${version:-dev}" \
  --data "{
	\"name\": \"MyFirstGitHubRelease\",
	\"start\": \"1731191180321\",
  	\"applications\": [
      {
        \"name\": \"TestAppNETDB\" 
      }
}")

echo $res

id=$(echo "$res" | jq ".id" -r)

echo ::set-output name=id::$id
