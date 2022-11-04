## ALPINE_VER can be overwritten with --build-arg
## Pinned version tag from https://hub.docker.com/_/alpine
ARG ALPINE_VER=3.14

########################################################################################
## STAGE ONE - BUILD
########################################################################################
FROM alpine:$ALPINE_VER AS tor-builder

## TOR_VER can be overwritten with --build-arg at build time
## Get latest version from > https://dist.torproject.org/
ARG TOR_VER=0.4.7.10
ARG TORGZ=https://dist.torproject.org/tor-$TOR_VER.tar.gz
ARG TOR_KEY=0x6AFEE6D49E92B601

## Install tor make requirements
RUN apk --no-cache add --update \
    alpine-sdk \
    gnupg \
    libevent libevent-dev \
    zlib zlib-dev \
    openssl openssl-dev

## Get Tor key file and tar source file
RUN wget $TORGZ.sha256sum.asc &&\
    wget $TORGZ.sha256sum &&\
    wget $TORGZ

## OLD: Get signature from key server
#RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys ${TOR_KEY}

## Fetch developers keys
RUN gpg --auto-key-locate nodefault,wkd --locate-keys ahf@torproject.org 2>&1 |\
    grep -q 'key BEA7B180B1491921: public key "Alexander Færøy <ahf@torproject.org>" imported' ||\
    { echo "Couldn't download the public key!"; exit 1; }
RUN gpg --auto-key-locate nodefault,wkd --locate-keys dgoulet@torproject.org 2>&1 |\
    grep -q 'key 42E86A2A11F48D36: public key "David Goulet <dgoulet@torproject.org>" imported' ||\
    { echo "Couldn't download the public key!"; exit 1; }
RUN gpg --auto-key-locate nodefault,wkd --locate-keys nickm@torproject.org 2>&1 |\
    grep -q 'key FE43009C4607B1FB: public key "Nick Mathewson <nickm@torproject.org>" imported' ||\
    { echo "Couldn't download the public key!"; exit 1; }

# Export in a file Nick key to after verify
RUN gpg --output ./tor.keyring --export 0x2133BC600AB133E1D826D173FE43009C4607B1FB
## Verify Tor source tarballs asc signatures
## Verify that the checksums file is PGP signed by the release signing key
## The .asc file will verify that the .sha256sum file (containing the checksum of the package) has not been tampered with
RUN gpgv --keyring ./tor.keyring ./tor-${TOR_VER}.tar.gz.sha256sum.asc ./tor-${TOR_VER}.tar.gz.sha256sum 2>&1 |\
    grep -q 'gpgv: Good signature from "Nick Mathewson <nickm@torproject.org>"' ||\
    { echo "Couldn't verify signature!"; exit 1; }
## Validated the signatures of the checksum, verify the integrity of the package
RUN sha256sum -c tor-${TOR_VER}.tar.gz.sha256sum 2>&1 |\
    grep -q "OK" ||\
    { echo "Not valid checksum!"; exit 1; }

## Make install Tor
RUN tar xfz tor-$TOR_VER.tar.gz &&\
    cd tor-$TOR_VER && \
    ./configure &&\
    make install

########################################################################################
## STAGE TWO - RUNNING IMAGE
########################################################################################
FROM alpine:$ALPINE_VER as release

## CREATE NON-ROOT USER FOR SECURITY
RUN addgroup --gid 1001 --system nonroot && \
    adduser  --uid 1000 --system --ingroup nonroot --home /home/nonroot nonroot

## Install Alpine packages
## bind-tools is needed for DNS resolution to work in *some* Docker networks
## Tini allows us to avoid several Docker edge cases, see https://github.com/krallin/tini.
RUN apk --no-cache add --update \
    bash \
    curl \
    libevent \
    tini bind-tools su-exec \
    openssl shadow coreutils \
    python3 py3-pip \
    && pip install nyx

## Data directories. Inside container
ENV DATA_DIR=/tor
## In the file system, container creation step
ENV SCRIPT_DIR=/bushido.market/src/scripts
ENV TOR_DIR=/bushido.market/etc/tor
ENV NYX_DIR=/bushido.market/etc/nyx

## Create tor directories
## Changed go+rX,u+rwX => 755
RUN mkdir -p ${DATA_DIR} && chown -R nonroot:nonroot ${DATA_DIR} && chmod -R 755 ${DATA_DIR}

## Copy compiled Tor daemon from tor-builder
COPY --from=tor-builder /usr/local/ /usr/local/

## Copy entrypoint shell script for templating torrc
## Changed go+rX,u+rwX => 755 and
## The below code cannot make it work so, use COPY and RUN commands #TODO
# COPY --chown=nonroot:nonroot --chmod=go+rX,u+rwX ${SCRIPT_DIR}/entrypoint.sh /usr/local/bin
COPY ${SCRIPT_DIR}/entrypoint.sh /usr/local/bin
RUN chown -R nonroot:nonroot /usr/local/bin && chmod -R 755 /usr/local/bin

## Copy client authentication for private/public keys
## Changed go+rX,u+rwX => 755 and
## the same as above #TODO
#COPY --chown=nonroot:nonroot --chmod=755 ${SCRIPT_DIR}/client_auth.sh /usr/local/bin
COPY ${SCRIPT_DIR}/client_auth.sh /usr/local/bin
RUN chown -R nonroot:nonroot /usr/local/bin && chmod -R 755 /usr/local/bin

## Copy torrc config and examples to tmp tor. Entrypoint will copy across to bind-volume
#COPY --chown=nonroot:nonroot ${TOR_DIR}/torrc* /tmp/tor/
## the same as above #TODO
COPY ${TOR_DIR}/torrc* /tmp/tor/
RUN chown -R nonroot:nonroot /tmp/tor/

#COPY --chown=nonroot:nonroot ${TOR_DIR}/tor-man.txt /tmp/tor/tor-man.txt
## the same as above #TODO
COPY ${TOR_DIR}/tor-man.txt /tmp/tor/tor-man.txt
RUN chown nonroot:nonroot /tmp/tor/tor-man.txt

## Copy nyxrc config into default location
## Changed go+rX,u+rwX => 755 and
## the same as above #TODO
# COPY --chown=nonroot:nonroot --chmod=755 ${NYX_DIR}/nyxrc /home/tor/.nyx/config
COPY ${NYX_DIR}/nyxrc /home/tor/.nyx/config
RUN chown -R nonroot:nonroot /home/tor/.nyx/config && chmod -R 755 /home/tor/.nyx/config

## Docker health check
HEALTHCHECK --interval=300s --timeout=15s --start-period=20s --retries=3 \
            CMD curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -s https://check.torproject.org/ | cat | \
            grep -m 1 Congratulations | xargs

## ENV VARIABLES
## Default values
ENV PUID= \
    PGID= \
    TOR_CONFIG_OVERWRITE="false" \
    TOR_LOG_CONFIG="false" \
    TOR_PROXY="true" \
    TOR_PROXY_PORT="9050" \
    TOR_PROXY_SOCKET="false" \
    TOR_PROXY_ACCEPT="accept 127.0.0.1" \
    TOR_CONTROL="false" \
    TOR_SERVICE="false" \
    TOR_RELAY="false"

## Label the docker image
LABEL name="Tor network client (daemon)"
LABEL version=$TOR_VER
LABEL description="Proxies the python request to nokyc APIs"
LABEL license="GNU"
LABEL url="https://www.torproject.org"

VOLUME [ "${DATA_DIR}" ]
WORKDIR ${DATA_DIR}
# located in /src/scripts/entrypoint.sh
ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
# The specified command will run after the executable specified in entrypoint
CMD ["tor", "-f", "/tor/torrc"]