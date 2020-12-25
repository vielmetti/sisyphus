FROM ghcr.io/openfaas/classic-watchdog:0.1.4 as watchdog

FROM alpine:3.12
RUN apk update && apk upgrade && apk add coreutils ca-certificates wget bash && update-ca-certificates

RUN mkdir -p /home/app

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

RUN wget -O /usr/bin/sisyphus "https://raw.githubusercontent.com/vielmetti/sisyphus/master/sisyphus" ; \
    chmod +x /usr/bin/sisyphus

# Add non root user
RUN addgroup -S app && adduser app -S -G app
RUN chown app /home/app

WORKDIR /home/app

USER app

# Populate example here - i.e. "cat", "sha512sum" or "node index.js"
ENV fprocess="/usr/bin/sisyphus"
# Set to true to see request in function logs
ENV write_debug="false"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
