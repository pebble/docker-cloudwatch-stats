# Docker Cloudwatch Stats #

Standalone container that reports current cpu/disk metrics of host EC2 instance to cloudwatch.

## Server Dependencies ##

  * Docker 1.5+

## Usage ##

1. Create systemd unit:

    ### docker-cloudwatch.service
    ```
    [Unit]
    Description=someapp cloudwatch stats
    After=docker.service
    Requires=docker.service

    [Service]
    TimeoutStartSec=0
    ExecStartPre=-/usr/bin/docker kill cloudwatch-stats
    ExecStartPre=-/usr/bin/docker rm cloudwatch-stats
    ExecStartPre=-/usr/bin/docker pull pebbletech/cloudwatch-stats
    ExecStart=/bin/sh -c '/usr/bin/docker run -e ASG=$(source /etc/profile; fleetctl list-machines -l | grep $(cat /etc/machine-id) | sed 's/.*service=//g') pebbletech/cloudwatch-stats'
    ```

2. Start systemd unit

    ```
    systemctl start $PWD/docker-cloudwatch.service
    ```
