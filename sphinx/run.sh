#!/bin/bash
WORKDIR=$1
DESTINATION=$2
OUTPUT_FILE=$3
shift
shift
shift

make -C "${WORKDIR}" html
retval=$?
if [[ $retval -ne 0 ]]; then
    anybadge --label=docs --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

OUTPUT_DIR=$(find "${WORKDIR}" -type d -name html -maxdepth 2)
retval=$?
echo "Output directory: ${OUTPUT_DIR}"
echo "Destination directory: ${DESTINATION}"
if [[ $retval -ne 0 ]]; then
    anybadge --label=docs --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

mv "${OUTPUT_DIR}" "${DESTINATION}"
retval=$?
if [[ $retval -ne 0 ]]; then
    anybadge --label=docs --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

anybadge --label=docs --value=passing --file="$OUTPUT_FILE" passing=green failing=red
