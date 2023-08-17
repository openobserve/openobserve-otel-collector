#!/bin/sh

GO111MODULE=on go install go.opentelemetry.io/collector/cmd/builder@latest
builder --config=manifest.yaml --name="otelcol" --version="0.0.3" --output-path=/tmp/dist

 