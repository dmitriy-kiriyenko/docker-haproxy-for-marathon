FROM ubuntu:14.04

# General
RUN apt-get update

# Install supervisor
RUN apt-get install -y supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install cron
RUN \
  apt-get install -y cron && \
  rm -f /etc/cron.daily/standard

# Install haproxy
RUN \
  apt-get install -y haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy
ADD haproxy.cfg /etc/haproxy/haproxy.cfg

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
