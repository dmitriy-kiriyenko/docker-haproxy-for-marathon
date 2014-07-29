FROM ubuntu:14.04

# General
RUN apt-get update

# Install supervisor
RUN apt-get install -y supervisor
ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install cron
RUN \
  apt-get install -y cron && \
  rm -f /etc/cron.daily/standard

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
ADD files/haproxy_reload /usr/local/bin/haproxy_reload
ADD files/haproxy_run /usr/local/bin/haproxy_run
ADD files/crontab /etc/crontab

EXPOSE 80 9090
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
