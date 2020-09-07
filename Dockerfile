FROM golang:1.14.8-alpine3.12
ARG TZ="Asia/Shanghai"
ENV TZ ${TZ}
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk upgrade --update && apk add bash tzdata curl && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
WORKDIR /opt/gohangout
COPY . /opt/gohangout
RUN ln -s /opt/gohangout/build/gohangout /usr/local/bin/gohangout
ENTRYPOINT [ "gohangout","--config", "config/filebeatkafka.yml" ]
