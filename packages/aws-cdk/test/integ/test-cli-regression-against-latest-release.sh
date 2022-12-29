#!/bin/bash
set -eu
# This is a backwards compatibility script. All logic has moved to '@aws-cdk-testing/cli-integ'
# and should be called from there directly.

# Contract: '@aws-cdk-testing/cli-integ' package is installed in ${INTEG_TOOLS}
previous=$(${INTEG_TOOLS}/bin/query-github last-release --token $GITHUB_TOKEN --prior-to $VERSION)
echo "Previous version is: $previous"

export OLD_TESTS=old_tests
$INTEG_TOOLS/bin/download-old-tests "$previous" "$OLD_TESTS"

# Old tests, new CLI, old framework
exec $OLD_TESTS/bin/run-suite --use-version=$VERSION --framework-version=$previous cli-integ-tests
