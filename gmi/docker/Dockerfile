FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && sed -i 'a https://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing' /etc/apk/repositories \
    && apk add --no-cache gmid git python3 perl \
    && touch /var/log/git.log \
    && echo "0  *  *  *  *  run-parts /etc/periodic/hourly" > /var/spool/cron/crontabs/root

RUN git clone https://github.com/dongdigua/dongdigua.github.io.git --depth 1 \
    && cd dongdigua.github.io \
    && git config filter.dater.smudge 'perl -pe "\$last_date = `git log --pretty=format:\\"%ad\\" -1`;s/\\\$Date\\\$/\\\$Date: \$last_date\\\$/"' \
    && git config filter.dater.clean 'perl -pe "s/\\\$Date[^\\\$]*\\\$/\\\$Date\\\$/"'

COPY run-wrapper.sh .
COPY gmid.conf /dongdigua.github.io/gmi/docker/
COPY update-git.sh /etc/periodic/hourly/
COPY cgi/*     /dongdigua.github.io/cgi/

# for testing purpose only
# RUN mkdir /etc/periodic/1min \
#     && echo "*/1  *  *  *  *  run-parts /etc/periodic/1min" \
#     >> /var/spool/cron/crontabs/root
# COPY update-git.sh /etc/periodic/1min/

CMD [ "./run-wrapper.sh" ]
