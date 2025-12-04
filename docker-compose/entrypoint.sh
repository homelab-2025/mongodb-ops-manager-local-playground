#!/bin/bash
set -e

# Start Ops Manager and continue.
/opt/mongodb/mms/bin/mongodb-mms start || true

# Tail important logs to keep the container running and allow logs to be
# observed through `docker logs`.
tail -F /data/appdb/mongodb.log /opt/mongodb/mms/logs/*.log || tail -f /dev/null
