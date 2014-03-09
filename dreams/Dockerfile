# v1
FROM phusion/passenger-full:0.9.8
ENV HOME /root

# Nginx
EXPOSE 80
RUN rm -f /etc/service/nginx/down
ADD dreams.conf /etc/nginx/sites-enabled/default

# App
RUN mkdir /home/app/build
ADD build /home/app/build

CMD ["/sbin/my_init"]
#RUN /usr/sbin/enable_insecure_key
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
