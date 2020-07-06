FROM vault:1.3.0

ADD tmp /tmp/
ADD run.sh /opt/

RUN apk update --no-cache \
    && apk add --no-cache jq \
    && chmod a+x /opt/run.sh

ENV SKIP_SETCAP=1
ENV VAULT_ADDR=http://0.0.0.0:8200

ENTRYPOINT ["/opt/run.sh"]
CMD ["server", "-dev"]
HEALTHCHECK --interval=5s --timeout=2s \
  CMD [[ -f /opt/healthcheck ]]
