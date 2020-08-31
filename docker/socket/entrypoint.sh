#!/usr/bin/env sh
set -e

IS_DOCKER_COMPOSE="${IS_DOCKER_COMPOSE:-false}"

if [ "$IS_DOCKER_COMPOSE" = false ] ; then
    AUTH_HOST="${AUTH_HOST:-http://nginx}";
    REDIS_HOST="${REDIS_HOST:-redis}";
    REDIS_PORT="${REDIS_PORT:-6379}";
    REDIS_PASSWORD="${REDIS_PASSWORD:-}";
    REDIS_KEY_PREFIX="${REDIS_KEY_PREFIX:-}";
    ALLOW_ORIGIN="${ALLOW_ORIGIN:-http://api.localhost}";

    sed -i "s#{{AUTH_HOST}}#${AUTH_HOST}#" "/app/laravel-echo-server.json";
    sed -i "s#{{REDIS_HOST}}#${REDIS_HOST}#" "/app/laravel-echo-server.json";
    sed -i "s#{{REDIS_PORT}}#${REDIS_PORT}#" "/app/laravel-echo-server.json";
    sed -i "s#{{REDIS_PASSWORD}}#${REDIS_PASSWORD}#" "/app/laravel-echo-server.json";
    sed -i "s#{{REDIS_KEY_PREFIX}}#${REDIS_KEY_PREFIX}#" "/app/laravel-echo-server.json";
    sed -i "s#{{ALLOW_ORIGIN}}#${ALLOW_ORIGIN}#" "/app/laravel-echo-server.json";
fi

exec "$@";
