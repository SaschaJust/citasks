#!/bin/bash
PYLINT_LOG=$1
OUTPUT_FILE=$2
shift
shift


echo "Executing pylint..."
pylint --output-format=text $@ | tee "$PYLINT_LOG"
retval=$?
if [[ $retval -ne 0 ]]; then
    anybadge --label=pylint --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

echo "Extracting score..."
SCORE=$(sed -n 's/^Your code has been rated at \([-0-9.]*\)\/.*/\1/p' "$PYLINT_LOG")
retval=$?
if [[ $retval -ne 0 ]]; then
    anybadge --label=pylint --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

echo "Creating badge..."
anybadge --value=$SCORE --file="$OUTPUT_FILE" pylint
retval=$?
if [[ $retval -ne 0 ]]; then
    anybadge --label=pylint --value=failing --file="$OUTPUT_FILE" passing=green failing=red
    exit $retval
fi

echo "Extracting report..."
grep -e '.*/.*:.*:.*:.*' "$PYLINT_LOG" | cut -d: -f4 | sort | uniq -c | sort -rg

exit 0
 