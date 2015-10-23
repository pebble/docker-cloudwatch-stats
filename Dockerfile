FROM gliderlabs/alpine:3.2

RUN apk --update add py-pip && pip install cloudwatchmon

CMD /usr/local/bin/mon-put-instance-stats.py \
    --mem-util \
    --disk-space-util \
    --disk-path=/ \
    --verbose
