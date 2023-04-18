FROM alpine:latest

# Keep credentilas to databases
ENV SERVER_NAME wpteam-mysqlserver.mysql.database.azure.com
ENV USER_NAME mysqladminun@wpteam-mysqlserver
ENV USER_PASSWORD H@Sh1CoR3!

# APT Update/Upgrade, then install packages we need
# RUN apt update && \
#     apt upgrade -y && \
#     apt autoremove && \
#     apt install -y \
#     vim \
#     wget \
#     mariadb-client

# Replace php.ini
# COPY php.ini /usr/local/etc/php

# Install WP-CLI
# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
#     php wp-cli.phar --info&& \
#     chmod +x wp-cli.phar && \
#     mv wp-cli.phar /usr/local/bin/wp && \
#     # Remove old php.ini files (wihtout creating new image)
#     rm /usr/local/etc/php/php.ini-development && \
#     rm /usr/local/etc/php/php.ini-production