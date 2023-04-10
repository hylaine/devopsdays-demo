#!/bin/bash
set -e

if [[ "$INSTALL_MYSQL" ]]; then
  lpm add mysql --global
fi

if type "$1" > /dev/null 2>&1; then
  ## First argument is an actual OS command. Run it
  exec "$@"
else
  if [[ "$*" == *--defaultsFile* ]] || [[ "$*" == *--defaults-file* ]] || [[ "$*" == *--version* ]]; then
    ## Just run as-is
    liquibase "$@"
  else
    ## Include standard defaultsFile
    liquibase "--defaultsFile=/liquibase/liquibase.docker.properties" "$@"
  fi
fi