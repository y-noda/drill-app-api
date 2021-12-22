FROM nginx:1.21.0
RUN apt-get update -qq && apt-get -y install apache2-utils
RUN rm -f /etc/nginx/conf.d/*
ADD nginx.conf /etc/nginx/conf.d/api.conf
ADD nginx.conf.template /etc/nginx/conf.d/api.conf.template
WORKDIR /api
