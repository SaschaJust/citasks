#!/bin/bash

DESTINATION=$1
OUTPUT_FILE=$2
shift
shift

make html
retval=$?
if [[ $retval -ne 0 ]]; then
    anybadge --label=docs --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

OUTPUT_DIR=$(find . -type d -name html -maxdepth 2)
retval=$?
if [[ $retval -ne 0 ]]; then
    anybadge --label=docs --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

mv "$OUTPUT_DIR" "${DESTINATION}"
retval=$?
if [[ $retval -ne 0 ]]; then
    anybadge --label=docs --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

anybadge --label=docs --value=passing --file="$OUTPUT_FILE" passing=green failing=red
