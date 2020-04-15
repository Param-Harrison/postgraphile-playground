#!/bin/bash

set -e
set -u

echo "Creating users '$POSTGRES_ANONYMOUS_USER' and '$POSTGRES_KNOWN_USER'"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d "$POSTGRES_DB" <<-EOSQL
  CREATE USER $POSTGRES_ANONYMOUS_USER;
  CREATE USER $POSTGRES_KNOWN_USER;
  
  -- Give CREATE, CONNECT, TEMPORARY permissions
  GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_ANONYMOUS_USER;  
  GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_KNOWN_USER;    
EOSQL
