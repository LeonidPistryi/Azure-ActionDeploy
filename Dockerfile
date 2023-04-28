FROM alpine:latest AS build

RUN apk add --no-cache mysql-client 

# To keep credentilas to databases
ENV SERVER_NAME wpteam-mysqlserver.mysql.database.azure.com
ENV USER_NAME mysqladminun@wpteam-mysqlserver
ENV USER_PASSWORD H@Sh1CoR3!

# Connect to the MySQL server and create a new database
CMD mysql -h $SERVER_NAME -u $USER_NAME -p$USER_PASSWORD -P 3306 -e "\
  CREATE DATABASE IF NOT EXISTS test_manifest12; \
  USE test_manifest12; \
  CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
  INSERT IGNORE  INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');" 

# APT Update/Upgrade, then install packages we need
# RUN apt update && \
#     apt upgrade -y && \
#     apt autoremove && \
#     apt install -y \
#     vim \
#     wget \
#     mariadb-client

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    php wp-cli.phar --info&& \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    # Remove old php.ini files (wihtout creating new image)
    rm /usr/local/etc/php/php.ini-development && \
    rm /usr/local/etc/php/php.ini-production