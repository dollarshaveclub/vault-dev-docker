FROM vault:1.3.0

RUN apk update --no-cache \
  && apk add --no-cache jq \
  && mv $(which docker-entrypoint.sh) /usr/local/bin/original-entrypoint.sh

ADD tmp /tmp/
ADD docker-entrypoint.sh /usr/local/bin/
ADD vault-dev-init.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/*

ENV SKIP_SETCAP=1
ENV VAULT_ADDR=http://0.0.0.0:8200

HEALTHCHECK --interval=5s --timeout=2s \
  CMD [[ -f /opt/healthcheck ]]
