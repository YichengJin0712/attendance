#!/bin/sh
set -eu
# Render uses PORT=10000 by default; local Docker uses 8080.
APP_PORT="${PORT:-8080}"
case "$APP_PORT" in
  *[!0-9]*|'') echo "PORT must be numeric" >&2; exit 1 ;;
esac
if [ "$APP_PORT" != "8080" ]; then
  sed -i "s/port=\"8080\"/port=\"${APP_PORT}\"/" "$CATALINA_HOME/conf/server.xml"
fi
exec "$CATALINA_HOME/bin/catalina.sh" run
