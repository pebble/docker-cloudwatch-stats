# Docker Cloudwatch Stats #

Standalone container intended to be run via cron/systemd.timer that reports
current cpu/disk metrics of host EC2 instance to cloudwatch.

## Server Dependencies ##

  * Docker 1.5+

## Usage ##

1. Create systemd unit and timer:

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
    ExecStart=/usr/bin/docker run -e "ASG=$(fleetctl list-machines -l | grep $(cat /etc/machine-id) | sed 's/.*service=//g')" --name cloudwatch-stats --privileged --rm pebbletech/cloudwatch-stats
    ```

    ### docker-cloudwatch.timer
    ```
    [Unit]
    Description=Run CloudWatch monitor every minute
    
    [Timer]
    OnCalendar=*:0/1
    Persistent=true
    
    [Install]
    WantedBy=timers.target
    ```

2. Start systemd timer

    ```
    systemctl start $PWD/docker-cloudwatch.timer
    ```
