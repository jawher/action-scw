#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 old_version new_version" >&2
    exit 1
fi

old_version=$1
new_version=$2

find . -type f -exec sed -i "s/${old_version}/${new_version}/g" {} \;

echo "Version updated from ${old_version} to ${new_version}"
