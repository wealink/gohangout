FROM alpine:3.8
ARG TZ="Asia/Shanghai"
ENV TZ ${TZ}
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk upgrade --update && apk add bash tzdata curl && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
WORKDIR /opt/gohangout
COPY . /opt/gohangout
ENTRYPOINT [ "/opt/gohangout/build/gohangout","--config", "/opt/gohangout/config/filebeatkafka.yml" ]
