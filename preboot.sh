#!/bin/sh

# write a pgpass file from an env var to auto-connect to a feature database
# format is:  hostname:port:database:username:password

# for multiple entries, pass in pgpass lines delimited by pipe character

USER_DIR=`echo $PGADMIN_DEFAULT_EMAIL | tr '@' '_'`
STORAGE_PATH=/var/lib/pgadmin/storage/$USER_DIR

if [ ! -z $PGPASS_FILE ]; then
  echo "writing auto-connection pgpass..."

  mkdir -m 700 -p $STORAGE_PATH
  echo $PGPASS_FILE | tr '|', "\n" > $STORAGE_PATH/pgpassfile
  chmod 600 $STORAGE_PATH/pgpassfile

  python build_servers.py $STORAGE_PATH/pgpassfile /pgadmin4/servers.json
fi

/entrypoint.sh
