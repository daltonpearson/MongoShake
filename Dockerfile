FROM golang:latest

# COPY . ./MongoShake
RUN git clone https://github.com/alibaba/MongoShake.git

# WORKDIR /go/MongoShake

RUN go get -u github.com/kardianos/govendor

ENV GOPATH=/go/MongoShake

WORKDIR /go/MongoShake/src/vendor/

RUN govendor sync -v

RUN go get -u golang.org/x/sync/semaphore && go get -u golang.org/x/text/transform && go get -u golang.org/x/text/unicode/norm

WORKDIR /go/MongoShake

RUN ./build.sh

RUN ls

# /go/MongoShake/bin/collector.linux -conf=/go/MongoShake/conf/collector.conf -verbose
CMD ["/go/MongoShake/bin/collector.linux" "-conf=/go/MongoShake/conf/collector.conf" "-verbose"]