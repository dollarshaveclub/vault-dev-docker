FROM vault:1.3.0

ADD tmp /tmp/
ADD docker-entrypoint.sh /usr/local/bin/

RUN apk update --no-cache \
    && apk add --no-cache jq

ENV SKIP_SETCAP=1
ENV VAULT_ADDR=http://0.0.0.0:8200

HEALTHCHECK --interval=5s --timeout=2s \
  CMD [[ -f /opt/healthcheck ]]
