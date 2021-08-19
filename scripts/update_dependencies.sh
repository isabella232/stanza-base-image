#!/usr/bin/env bash

set -e

apt-get update -qq -o=Dpkg::Use-Pty=0
apt-get install -qq -o=Dpkg::Use-Pty=0 -y python jq

JSON=$( cat dependencies.json )
echo "detecting versions for ${JSON}"

for PACKAGE in $( echo "${JSON}" | jq -r 'keys | .[]' ); do
	VERSION=$( apt-cache policy "${PACKAGE}" | grep -oP '(?<=Candidate:\s)(.+)' )
	JSON=$( echo "${JSON}" | jq '.[$package] = $version' --arg package "${PACKAGE}" --arg version "${VERSION}" )
done

echo "${JSON}" | python -m json.tool > dependencies.json