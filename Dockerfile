FROM gliderlabs/alpine:3.2

RUN apk --update add coreutils py-pip && pip install cloudwatchmon

CMD sed '1d' -i /etc/mtab && /usr/bin/mon-put-instance-stats.py \
    --mem-util \
    --disk-space-util \
    --disk-path=/ \
    --verbose
