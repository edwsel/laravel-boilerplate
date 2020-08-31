#!/usr/bin/env sh
set -e

while [ true ]; do
    sleep 60;

    exec ${COMMAND_FOR_RUN:-php /app/artisan schedule:run}
done