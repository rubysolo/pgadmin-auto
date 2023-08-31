FROM dpage/pgadmin4:7.6

# build an image of pgadmin that auto-connects to the specified server
# pass the contents of a pgpass file as the env var PGPASS_FILE

USER root
RUN touch /pgadmin4/servers.json && chown pgadmin /pgadmin4/servers.json

USER pgadmin
COPY build_servers.py /pgadmin4/build_servers.py
COPY preboot.sh /preboot.sh

ENTRYPOINT [ "/preboot.sh" ]
