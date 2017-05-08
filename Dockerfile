FROM debian:jessie

MAINTAINER Redis Docker Maintainers "280417314@qq.com"

# redis config git
ENV REDIS_GIT https://github.com/mypjb/redis-docker.git

#redis download url
ENV REDIS_URL http://download.redis.io/releases/redis-3.2.8.tar.gz

#redis path
ENV REDIS_PATH /usr/local/redis

RUN apt-get update -y

RUN apt-get install -y gcc make wget net-tools git nano \
	&& wget $REDIS_URL -o redis.tar.gz \
	&& mkdir -p $REDIS_PATH \
	&& tar -xzf redis.tar.gz -C $REDIS_PATH --strip-components=1 \
	&& rm -rf redis.tar.gz \
	&& cd $REDIS_PATH \
	&& make \
	&& git clone $REDIS_GIT redis_git \
	&& cp -rf redis_git/* ./ 
	&& ln -s $REDIS_PATH/src/redis-server /usr/local/bin

EXPOSE 6379

CMD redis-server ; /bin/bash ;
	

	


