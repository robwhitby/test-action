#!/usr/bin/env bash
echo $GITHUB_REF > .gitRef

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "running entrypoint.sh $1"
export PATH="$PATH:$DIR"

cf7 -v

echo cf_api = $INPUT_CF_API
exit 0

cat << EOF > /tmp/request
{
    "source": {
        "api": "$INPUT_CF_API",
        "org": "$INPUT_CF_ORG",
        "space": "$INPUT_CF_SPACE",
        "username": "$INPUT_CF_USERNAME",
        "password": "$INPUT_CF_PASSWORD"
    },
    "params": {
      "command": "$1",
      "manifestPath": "$INPUT_MANIFEST_PATH",
      "appPath": "$INPUT_APP_PATH",
      "testDomain": "$INPUT_TEST_DOMAIN",
      "gitRefPath": ".gitRef",
      "cliVersion": "cf7"
    }
}
EOF

cat /tmp/request | deploy `pwd`
