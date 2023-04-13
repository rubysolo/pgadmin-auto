import json
import sys

# Usage: build_servers.py PGPASS_FILE SERVERS_JSON_FILE

servers = {}

pgpass_fh = open(sys.argv[1])
for index, entry in enumerate(pgpass_fh.read().splitlines()):
    hostname, port, database, username, password = entry.split(":", 4)

    server = {
        "Name": hostname,
        "Group": "Servers",
        "Host": hostname,
        "Port": int(port),
        "MaintenanceDB": database,
        "Username": username,
        "SSLMode": "prefer",
        "PassFile": "/pgpassfile",
    }

    servers[str(index + 1)] = server

json_fh = open(sys.argv[2], "w+")
json_fh.write(json.dumps({"Servers": servers}, indent=2))
