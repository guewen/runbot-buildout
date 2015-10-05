#!/bin/bash

# This script launch the scenario with the tags @runbot @setup @config
# It does not use bin/oerpscenario because this script loads all the
# features files it finds which provoke conflicts with the feature 
# files of the builds

set -e

ROOTDIR=$(dirname $0)
BEHAVE=${ROOTDIR}/bin/behave
BASE_FEATURES=${ROOTDIR}/Scenario/OERPScenario/features
RUNBOT_FEATURES=${ROOTDIR}/Scenario/OERPScenario.local/features
TAGS="-t runbot -t setup -t config"
${BEHAVE} -k --no-capture ${BASE_FEATURES} ${RUNBOT_FEATURES} ${TAGS}

set +e
