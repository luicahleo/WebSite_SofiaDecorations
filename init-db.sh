#!/bin/bash
set -e

ODOO_USER=$(tr -d '\r\n' < /run/secrets/odoo_db_user)
ODOO_PASSWORD=$(tr -d '\r\n' < /run/secrets/odoo_db_password)
SUPERUSER=$(tr -d '\r\n' < /run/secrets/pg_superuser)

psql -v ON_ERROR_STOP=1 --username "$SUPERUSER" --dbname "postgres" <<-EOSQL
    CREATE USER "${ODOO_USER}" WITH CREATEDB PASSWORD '${ODOO_PASSWORD}';
EOSQL

echo "Usuario de base de datos '${ODOO_USER}' creado correctamente."
