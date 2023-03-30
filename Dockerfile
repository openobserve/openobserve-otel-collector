# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM public.ecr.aws/docker/library/golang:1.19 as build
ARG TARGETOS TARGETARCH

WORKDIR /go/src/app
COPY zinclabs-otel-collector-builder.yaml .
ENV CGO_ENABLED=0 

RUN GO111MODULE=on go install go.opentelemetry.io/collector/cmd/builder@latest
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH builder --config=zinclabs-otel-collector-builder.yaml --name="zinclabs-otel-collector" --version="0.0.1" --output-path=/go/bin/app

# Now copy it into our base image.
FROM gcr.io/distroless/static-debian11
COPY --from=build /go/bin/app /
CMD ["/zinclabs-otel-collector", "--config", "/etc/otelcol/config.yaml"]
EXPOSE 4317 55678 55679
