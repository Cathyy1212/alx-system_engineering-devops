#!/usr/bin/env bash
# Configure Nginx so that its HTTP response contains
# a custom header
#
balancer="\
frontend haproxy_balancer
    bind *:80
    mode http
    default_backend webservers
    
backend webservers
    balance roundrobin
    server 26071-web-01 44.210.150.159:80 check
    server 26071-web-02 35.173.47.15:80 check
"
# Update packages
apt-get -y update
apt-get -y upgrade

# Add HAProxy PPA
apt-get -y install software-properties-common
add-apt-repository -y ppa:vbernat/haproxy-2.5
apt-get -y update

# Install HAProxy
apt-get -y install haproxy
cp -a /etc/haproxy/haproxy.cfg{,.orig}
echo "$balancer" >> /etc/haproxy/haproxy.cfg
service haproxy restart
root@fcc56b1b1935:/alx-system_engineering-devops/0x0F-load_ba
lancer# cat 2-puppet_custom_http_response_header.pp 
# Automation: creates a custom HTTP header response with Puppet.
exec { 'command':
  command  => 'apt-get -y update;
  apt-get -y install nginx;
  sudo sed -i "/listen 80 default_server;/a add_header X-Served-By $HOSTNAME;" /etc/nginx/sites-available/default;
  service nginx restart',
  provider => shell,
}
