# syntax=docker/dockerfile:1.2
ARG ARCH
FROM --platform=$ARCH ubuntu

# Install libsqlite3-dev
RUN apt-get update && apt-get install -y libsqlite3-dev

# Copy the compiled binary
ARG BINARY
COPY $BINARY /app

# Set the binary as the entry point
ENTRYPOINT ["/app"]
