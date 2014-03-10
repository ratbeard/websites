# v1
FROM phusion/passenger-full:0.9.8
ENV HOME /root

# Nginx
EXPOSE 7777
RUN rm -f /etc/service/nginx/down
ADD site.conf /etc/nginx/sites-enabled/default

# node
ADD package.json /home/app/package.json
RUN cd /home/app && npm install --production

# App
ADD . /home/app/
RUN chown -R app:app /home/app
RUN ["/home/app/node_modules/.bin/coffee", "-c", "/home/app/app.coffee"]

CMD ["/sbin/my_init"]
#RUN /usr/sbin/enable_insecure_key
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
