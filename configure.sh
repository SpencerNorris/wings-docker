#!/bin/bash
set -e
${CATALINA_HOME}/bin/shutdown.sh
${CATALINA_HOME}/bin/startup.sh
echo "Wings initialization complete."
