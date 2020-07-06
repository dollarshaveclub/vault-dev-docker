FROM vault:1.3.0

ARG ENTRYPOINT_DIR=/usr/local/bin

RUN apk update --no-cache \
  && apk add --no-cache jq \
  && mv ${ENTRYPOINT_DIR}/docker-entrypoint.sh ${ENTRYPOINT_DIR}/original-entrypoint.sh

ADD tmp /tmp/
ADD bin/ ${ENTRYPOINT_DIR}
RUN chmod a+x ${ENTRYPOINT_DIR}/*

ENV SKIP_SETCAP=1
ENV VAULT_ADDR=http://0.0.0.0:8200

HEALTHCHECK --interval=5s --timeout=2s \
  CMD [[ -f /opt/healthcheck ]]
