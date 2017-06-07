FROM centos

MAINTAINER Redis Docker Maintainers "280417314@qq.com"

# redis config git
ENV REDIS_GIT https://github.com/mypjb/redis-docker.git

#redis download url
ENV REDIS_URL http://download.redis.io/releases/redis-3.2.8.tar.gz

#redis path
ENV REDIS_PATH /usr/local/redis

RUN yum update -y

RUN yum install -y gcc make net-tools git nano wget \
	&& wget $REDIS_URL -O redis.tar.gz \
	&& mkdir -p $REDIS_PATH \
	&& tar -xvf redis.tar.gz -C $REDIS_PATH --strip-components=1 \
	&& rm -rf redis.tar.gz \
	&& cd $REDIS_PATH \
	&& make \
	&& git clone $REDIS_GIT redis_git \
	&& mkdir conf \
	&& cp -rf redis_git/conf/* ./conf \
	&& ln -s $REDIS_PATH/src/redis-server /usr/local/bin \
	&& rm -rf redis_git 

	
EXPOSE 6379

CMD redis-server $REDIS_PATH/conf/redis.conf ; /bin/bash ;
