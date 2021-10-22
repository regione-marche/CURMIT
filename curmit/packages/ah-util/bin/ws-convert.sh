#!/bin/sh

wget http://80.88.171.52:8080/converter/service --post-file=$1 --header="Content-Type: $3" --header="Accept: $2" --output-document=$4 --append-output=/tmp/wget.log
