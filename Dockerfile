FROM alpine:latest

ENV MYSQL_ROOT_PASSWORD=root


# docker run 
# --detach 
# --name=[container_name] 
# --env="MYSQL_ROOT_PASSWORD=[my_password]" 
# --publish 6603:3306 
# --volume=/root/docker/[container_name]/conf.d:/etc/mysql/conf.d 
# mysql