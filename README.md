## Introduction
The Laravel-Boilerplate provide you with massive head start on any size web application. Out of the box is has pure Laravel-framework and start docker images.

## Docker images
| Images           | About                                                      |
|------------------|------------------------------------------------------------|
| Traefik          | https://hub.docker.com/_/traefik                        |
| Mail-hog        | https://hub.docker.com/r/mailhog/mailhog                 |
| Redis            | https://hub.docker.com/_/redis                          |
| Redis-commander | https://hub.docker.com/r/rediscommander/redis\-commander |
| Mariadb          | https://hub.docker.com/_/mariadb                        |
| Core             | Image for CLI                                              |
| FPM              |                                                            |
| Nginx            |                                                            |
| Cron             | Image for run Laravel scheduler                            |
| Socket           | Image for run Laravel broadcast                            |
| Worker-Default  | Image for run Laravel default worker queue                 |
| Worker-Socket   | Image for run Laravel broadcast worker queue               |

## Install
1. Clone this repository or download.
```
git clone https://github.com/edwsel/laravel-boilerplate.git
```

2. Change into the working directory.
```
cd laravel-boilerplate
```

3. Run **core** container via docker-compose.
```
docker-compose up -d core
```

4. Run install command vie proxy shell script
```
./proxy.sh install
```
5. Run all other container via docker-compose
```
docker-compose up -d
```

## License
The Laravel-Boilerplate framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
