#!/bin/sh

# write a pgpass file from an env var to auto-connect to a feature database
# format is:  hostname:port:database:username:password

STORAGE_PATH=/var/lib/pgadmin/storage/pgadmin4_pgadmin.org

if [ ! -z $PGPASS_FILE ]; then
  echo "writing auto-connection pgpass..."
  mkdir -m 700 -p $STORAGE_PATH
  echo $PGPASS_FILE > $STORAGE_PATH/pgpassfile
  chmod 600 $STORAGE_PATH/pgpassfile

  hostname=`echo $PGPASS_FILE | cut -d':' -f 1`
  port=`echo $PGPASS_FILE | cut -d':' -f 2`
  database=`echo $PGPASS_FILE | cut -d':' -f 3`
  username=`echo $PGPASS_FILE | cut -d':' -f 4`
  password=`echo $PGPASS_FILE | cut -d':' -f 5`

  cat > /pgadmin4/servers.json <<EOF
{
  "Servers": {
      "1": {
          "Name": "$hostname",
          "Group": "Servers",
          "Host": "$hostname",
          "Port": $port,
          "MaintenanceDB": "$database",
          "Username": "$username",
          "SSLMode": "prefer",
          "PassFile": "/pgpassfile"
      }
  }
}
EOF
fi

/entrypoint.sh
