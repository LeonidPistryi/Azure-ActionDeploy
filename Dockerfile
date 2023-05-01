FROM alpine:3.14

RUN apk add --no-cache mysql-client
RUN mkdir -p /var/www/html/ && chmod 777 /var/www/html/

# To keep credentilas to databases
ENV SERVER_NAME wpteam-mysqlserver.mysql.database.azure.com
ENV USER_NAME mysqladminun@wpteam-mysqlserver
ENV USER_PASSWORD H@Sh1CoR3!
ENV TITLE Hello
ENV URL http://localhost

RUN apk add --no-cache \
        less \
        php7 \
        php7-curl \
        php7-json \
        php7-mbstring \
        php7-mysqli \
        php7-phar \
        php7-openssl \
        php7-dom \
        php7-xml \
        php7-xmlwriter \
        php7-simplexml 

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
  && chmod +x /usr/local/bin/wp 

# Connect to the MySQL server and create a new database
CMD mysql -h $SERVER_NAME -u $USER_NAME -p$USER_PASSWORD -P 3306 -e "\
  CREATE DATABASE IF NOT EXISTS test_manifest12; \
  USE test_manifest12; \
  CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
  INSERT IGNORE  INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe');"  && \
wp core download --path=/var/www/html --allow-root && \
wp --allow-root --path=/var/www/html config create \
  --dbhost=wpteam-mysqlserver.mysql.database.azure.com \
  --dbname=test_manifest12 \
  --dbuser=$USER_NAME \
  --dbpass=H@Sh1CoR3! \
  --allow-root && \
wp --allow-root --path=/var/www/html core install \
  --title=$TITLE \
  --url=$URL \
  --admin_user=admin \
  --admin_password=12345 \
  --admin_email=admin@example.com \
# add for skip creation default themes
  --skip-themes \
# add for skip creation default plugins
  --skip-plugins \
  --allow-root
  