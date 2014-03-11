FROM phusion/passenger-full:0.9.8

# Data
RUN mkdir /data
RUN chmod -R 777 /data

# Without this, root owns the directory.  Snaggle
RUN echo blah > /data/test
VOLUME ["/data"]
CMD ["/bin/true"]

