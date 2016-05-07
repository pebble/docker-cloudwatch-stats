FROM alpine:3.3

RUN apk --update add \
    coreutils \
    py-pip \
    && pip install https://github.com/pebble/cloudwatch-mon-scripts-python/tarball/master\#egg\=cloudwatchmon-2.0.3 \
    && rm -rf /var/cache/apk/* 

CMD sed '1d' -i /etc/mtab && /usr/bin/mon-put-instance-stats.py \
    --mem-util \
    --disk-space-util \
    --disk-path=/ \
    --auto-scaling \
    --auto-scaling-group=$ASG

