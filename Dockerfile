FROM gliderlabs/alpine:3.2

RUN apk --update add \
    coreutils \
    py-pip \
    git \
    && pip install git+https://github.com/pebble/cloudwatch-mon-scripts-python.git@add_persistent_put_option

CMD sed '1d' -i /etc/mtab && /usr/bin/mon-put-instance-stats.py \
    --mem-util \
    --disk-space-util \
    --disk-path=/ \
    --auto-scaling \
    --auto-scaling-group=$ASG \
    --persistent
