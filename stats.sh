#!/bin/sh

sed '1d' -i /etc/mtab && /usr/bin/mon-put-instance-stats.py \
    --mem-util \
    --disk-space-util \
    --disk-path=/ \
    --auto-scaling \
    --auto-scaling-group=$ASG \
    --persistent $*
