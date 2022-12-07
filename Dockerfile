# Start by building the application.
FROM public.ecr.aws/docker/library/golang:1.19 as build

WORKDIR /go/src/app
COPY otelcol-builder.yaml .

RUN GO111MODULE=on go install go.opentelemetry.io/collector/cmd/builder@latest
RUN builder --config=zinclabs-otel-collector-builder.yaml --name="zinclabs-otel-collector" --version="0.0.1" --output-path=/go/bin/app

# Now copy it into our base image.
FROM gcr.io/distroless/static-debian11
COPY --from=build /go/bin/app /
CMD ["/zinclabs-otel-collector"]

