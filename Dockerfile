FROM golang:1.14.8-alpine3.12
ARG TZ="Asia/Shanghai"
ENV TZ ${TZ}
WORKDIR /opt/gohangout
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk upgrade --update && apk add bash tzdata curl && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && apk add build-base
COPY . /opt/gohangout
RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct && make
RUN go build -buildmode=plugin -o plugin/filebeatkafka/filebeatkafka.so plugin/filebeatkafka/filebeatkafka.go

CMD [ "sh", "-c","build/gohangout --config config/filebeatkafka.yml -logtostderr -v 5" ]
