FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && sed -i 'a https://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing' /etc/apk/repositories \
    && apk add agate git \
    && touch /var/log/git.log

RUN git clone https://github.com/dongdigua/dongdigua.github.io.git --depth 1

COPY run-wrapper.sh .
# https://weinan.io/2019/04/06/cron.html
COPY update-git.sh /etc/periotic/daily/

# for testing purpose only
# RUN mkdir /etc/periodic/1min \
#     && echo "*/1  *  *  *  *  run-parts /etc/periodic/1min" \
#     >> /var/spool/cron/crontabs/root
# COPY update-git.sh /etc/periodic/1min/


CMD [ "./run-wrapper.sh" ]
