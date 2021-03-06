#!/bin/bash

#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e
set -u
set -o pipefail

GRAKN_VERSION=${GRAKN_VERSION:-1.5.7}

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

echo "JAVA_HOME=${JAVA_HOME}"
export PATH="${JAVA_HOME}/bin:${PATH}"
java -version

echo -n "Grakn version: (see bottom of the startup text banner)"
echo ""

(env | grep _JAVAOPTS) || true 

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-all-linux-${GRAKN_VERSION}/grakn server start --benchmark
echo "^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Grakn server is running..."

if [[ "${SKIP_GRAQL:-}" = "true" ]]; then
	echo "Skipping running Graql console"
else
	echo "Starting Graql console..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	time ./grakn-core-all-linux-${GRAKN_VERSION}/grakn console
fi