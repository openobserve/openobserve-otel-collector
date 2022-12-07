#!/bin/sh

GO111MODULE=on go install go.opentelemetry.io/collector/cmd/builder@latest
builder --config=zinclabs-otel-collector-builder.yaml --name="zinclabs-otel-collector" --version="0.0.1" --output-path=/tmp/dist

