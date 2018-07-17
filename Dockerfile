FROM vault:latest

RUN apk add --no-cache dumb-init jq

ENV SKIP_SETCAP=1
ENV VAULT_ADDR=http://0.0.0.0:8200

COPY *.json /tmp/
COPY run.sh /opt/run.sh

ENTRYPOINT ["/opt/run.sh"]
CMD ["server", "-dev"]
HEALTHCHECK --interval=5s --timeout=2s \
  CMD [[ -f /opt/healthcheck ]]
