FROM alpine:3.8
ARG TZ="Asia/Shanghai"
ENV TZ ${TZ}
RUN apk upgrade --update && apk add bash tzdata curl && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
WORKDIR /opt/gohangout
ADD ./ /opt/gohangout/
CMD [ "sh", "-c", "./build/gohangout --config config/filebeatkafka.yml" ]
