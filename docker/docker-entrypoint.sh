#!/bin/bash
#
# docker-entrypoint for docker-solr
set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

# when invoked with e.g.: docker run solr -help
if [ "${1:0:1}" = '-' ]; then
    set -- solr-foreground "$@"
fi

chown 8983:8983 /opt/solr/reportek/solr/collection1/data

# execute command passed in as arguments.
# The Dockerfile has specified the PATH to include
# /opt/solr/bin (for Solr) and /opt/docker-solr/scripts (for our scripts
# like solr-foreground, solr-create, solr-precreate, solr-demo).
# Note: if you specify "solr", you'll typically want to add -f to run it in
# the foreground.

exec sudo -u $SOLR_USER -H PATH=$PATH SOLR_USER=$SOLR_USER SOLR_UID=$SOLR_UID SOLR_GROUP=$SOLR_GROUP SOLR_GID=$SOLR_GID SOLR_HOME=$SOLR_HOME sh -c "$@"
