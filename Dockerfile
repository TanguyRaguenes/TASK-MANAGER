FROM golang:1.25.6-trixie AS build
RUN apt update && apt install -y git npm nodejs
RUN git clone https://github.com/prometheus/prometheus.git
WORKDIR /go/prometheus
RUN git checkout v2.53.5
RUN make build

FROM scratch
COPY --from=build /go/prometheus/prometheus /
COPY --from=build /go/prometheus/promtool /
ENTRYPOINT ["/prometheus"]
CMD ["--help"]
