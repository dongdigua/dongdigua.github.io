FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && sed -i 'a https://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing' /etc/apk/repositories \
    && apk add agate git

RUN git clone https://github.com/dongdigua/dongdigua.github.io.git --depth 1

COPY run-wrapper.sh .
COPY update-git.sh /etc/periotic/daily/


CMD [ "./run-wrapper.sh" ]
