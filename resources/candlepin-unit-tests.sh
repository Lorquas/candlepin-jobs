#!/bin/bash -xe

env | sort
echo

# The docker container test script will know to copy out
echo "Using workspace: $WORKSPACE"
mkdir -p $WORKSPACE/artifacts/

# make selinux happy via http://stackoverflow.com/a/24334000
chcon -Rt svirt_sandbox_file_t $WORKSPACE//artifacts/

# Run the Candlepin unit tests
./docker/test -p -c 'cp-test -uuu -c "${sha1}"' -n "unit-tests-${BUILD_TAG}"
sudo chown -R jenkins:jenkins $WORKSPACE/artifacts
