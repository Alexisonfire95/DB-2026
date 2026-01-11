#!/bin/bash

export $(grep -v '^#' .env | xargs)

if [[ $1 == *".sql" ]]; then
  docker exec -i labs.database psql -U $DB_USER -d $DB_NAME < "$1"
else
  docker exec -i labs.database psql -U $DB_USER -d $DB_NAME -c "$1"
fi