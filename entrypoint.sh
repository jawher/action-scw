#!/bin/sh

set -euo pipefail

: "${SCW_ACCESS_KEY?SCW_ACCESS_KEY environment variable must be set}"
: "${SCW_SECRET_KEY?SCW_SECRET_KEY environment variable must be set}"
: "${SCW_ORGANIZATION_ID?SCW_ORGANIZATION_ID environment variable must be set}"
: "${SCW_ZONE?SCW_ZONE environment variable must be set}"
: "${SCW_REGION:=}"

# Map env vars to what scw expect
export SCW_DEFAULT_ORGANIZATION_ID="${SCW_ORGANIZATION_ID}"
export SCW_DEFAULT_ZONE="${SCW_ZONE}"

# Only export SCW_DEFAULT_REGION if explicitly set by user
if [ -n "${SCW_REGION}" ]; then
  export SCW_DEFAULT_REGION="${SCW_REGION}"
fi

# Run and preserve output for consumption by downstream actions
/scw "$@" >"${GITHUB_WORKSPACE}/scw.output"

# Write output to STDOUT
cat "${GITHUB_WORKSPACE}/scw.output"
