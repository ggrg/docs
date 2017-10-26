## Configuring High Availability Proxy ##

### Introduction

Load balancing across multiple server instances is one of the amazing techniques and ways for optimizing resource utilization, maximizing throughput, and reducing latency to ensure high availability of servers in an environment where some concurrent requests are in millions from users or clients and appear in a very fast and reliable manner. 

This Document explains about Installing and configuring HAProxy on AWS EC2 Instance

HAProxy is free, open source software that provides a high availability load balancer and proxy server for TCP and HTTP-based applications that spreads requests across multiple servers. It is written in C and has a reputation for being fast and efficient (in terms of processor and memory usage).

### Install HAProxy

Install a HA Proxy in AWS EC2 Instance by Issuing the command ‘sudo yum install --enablerepo=epel haproxy’.

After the Successful Installation check the version Installed by Issuing the command ‘haproxy -version’.

         Senthilkumars-MacBook-Pro:HaProxy-Mule  senthil$ haproxy -version
         HA-Proxy version 1.7.4 2017/03/27

Create a Config file for Mule Instances

### Sample Config file


        listen  stats
          bind *:9002
          mode            http
          log             global
          maxconn 10
          clitimeout      100s
          srvtimeout      100s
          contimeout      100s
          timeout queue   100s
          stats enable
          stats hide-version
          stats refresh 30s
          stats show-node
          stats auth admin:mypassword
          stats uri  /haproxy?stats
          stats admin if TRUE
        frontend localnodes
          bind *:9001
          mode http
          default_backend nodes
        backend nodes
          mode http
          balance roundrobin
          server DFSP1-Test ec2-52-32-100-1.us-west-2.compute.amazonaws.com:8088 maxconn 100 check
          server DFSP2-Test ec2-52-32-200-2.us-west-2.compute.amazonaws.com:8088 maxconn 100 check

After creating the configuration file for the Mule Instance place it under any any directory (Eg: /home/ec2-user/scripts/modusbox/haproxy), 

Execute the following command from the directory to run the load balancer configuration

      haproxy -f haproxy_mule.cfg

After the successful execution, Now you will be able access the Mule APIs with the URL

      http://<AWS ec2 Instance>:9001/

Status of the load balancer can viewed thru the browser under the path

      http://<AWS ec2 Instance>:9002/
