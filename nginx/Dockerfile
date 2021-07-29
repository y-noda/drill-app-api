FROM nginx:1.21.0
RUN apt-get update -qq && apt-get -y install apache2-utils
RUN rm -f /etc/nginx/conf.d/*
ADD nginx.conf /etc/nginx/conf.d/api.conf
WORKDIR /api
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf