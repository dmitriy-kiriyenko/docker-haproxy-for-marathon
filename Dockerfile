FROM ubuntu:14.04

# General
RUN apt-get update

# Install haproxy
ENV HAPROXY_CONF /etc/haproxy/haproxy.cfg
ENV HAPROXY_PID /var/run/haproxy.pid
RUN \
  apt-get install -y haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy
ADD files/haproxy.cfg $HAPROXY_CONF

# Configure service discovery
RUN apt-get install -y curl
RUN locale-gen en_US.UTF-8
ADD \
  files/haproxy_dns_cfg \
  /usr/local/bin/haproxy_dns_cfg
RUN chmod +x /usr/local/bin/haproxy_dns_cfg

EXPOSE 80 9090
CMD ["/usr/bin/supervisord"]
