FROM ubuntu:14.04

# General
RUN apt-get update

# Install haproxy
ENV HAPROXY_CONF /etc/haproxy/haproxy.cfg
RUN \
  apt-get install -y haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy
ADD files/haproxy.cfg $HAPROXY_CONF

# Configure service discovery
ENV RELOAD_TTL 5
ENV DISCOVERY_URL localhost:8080
RUN apt-get install -y curl
RUN locale-gen en_US.UTF-8
ADD \
  files/haproxy_dns_cfg \
  /usr/local/bin/haproxy_dns_cfg
ADD files/discovery_start /usr/local/bin/discovery_start

EXPOSE 80 9090
CMD ["discovery_start"]
