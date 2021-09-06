#!/usr/bin/env bash

install() {
    command /bin/bash -c "\"composer create-project --prefer-dist laravel/laravel tmp_laravel\""
    command /bin/bash -c "\"cp -ar ./tmp_laravel/. ./\""
    command /bin/bash -c "\"rm -rf ./tmp_laravel"\"
}

command() {
    command="docker exec -it core $@";
    echo $command
    eval $command;
}

cli() {
    command="docker exec -it core /bin/bash";
    echo $command
    eval $command;
}

composer() {
    command="docker exec -it core /bin/bash -c \"composer $@\"";
    echo $command
    eval $command;
}

artisan() {
    command="docker exec -it core /bin/bash -c \"php artisan $@\"";
    echo $command
    eval $command;
}

yarn() {
    command="docker exec -it core /bin/bash -c \"yarn $@\"";
    echo $command
    eval $command;
}

db() {
    command="docker exec -it mariadb /usr/bin/mysql -u root -psecret -b fuzzz";
    echo $command
    eval $command;
}

args=($@)
if [ -z "$1" ]; then
    printf 'First arg is empty \n'
    exit 1
fi

if [ $1 = "install" ]; then
    install
elif [ $1 = "command" ]; then
    command ${args[@]:1}
elif [ $1 = "composer" ]; then
    composer ${args[@]:1}
elif [ $1 = "cli" ]; then
    cli
elif [ $1 = "artisan" ]; then
    artisan ${args[@]:1}
elif [ $1 = "yarn" ]; then
    yarn ${args[@]:1}
elif [ $1 = 'db' ]; then
    db
else
    printf 'Command [%s] not found \n' $1
    exit 1
fi