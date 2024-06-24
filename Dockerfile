FROM --platform="${BUILDPLATFORM:-linux/amd64}" docker.io/busybox:1.36.1 as builder

ARG TARGETOS TARGETARCH TARGETVARIANT

WORKDIR /app
COPY pyrra .

RUN chmod +x pyrra

FROM --platform="${TARGETPLATFORM:-linux/amd64}"  docker.io/alpine:3.20.1 AS runner
WORKDIR /
COPY --chown=0:0 --from=builder /app/pyrra /usr/bin/pyrra
USER 65533

ENTRYPOINT ["/usr/bin/pyrra"]
