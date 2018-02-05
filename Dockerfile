FROM alpine:3.7

RUN apk update && apk upgrade && apk add coreutils ca-certificates wget && update-ca-certificates

ENV FWATCHDOG_VERSION 0.6.5

RUN set -eux; \
    apkArch="$(apk --print-arch)" ; \
# what system are we on
    case "$apkArch" in \
        x86_64)  export FWATCHDOG=fwatchdog ;; \
	      armhf)   export FWATCHDOG=fwatchdog-armhf ;; \
        aarch64) export FWATCHDOG=fwatchdog-arm64 ;; \
    esac; \
    wget -O /usr/bin/fwatchdog "https://github.com/alexellis/faas/releases/download/$FWATCHDOG_VERSION/$FWATCHDOG"; \
    chmod +x /usr/bin/fwatchdog ; \
    wget -O /usr/local/lib/sisyphus.txt "https://raw.githubusercontent.com/vielmetti/sisyphus/master/sisyphus.txt"

ENV fprocess="/usr/bin/shuf -n 1 /usr/local/lib/sisyphus.txt"
CMD ["fwatchdog"]
