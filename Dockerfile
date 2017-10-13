FROM six8/pyinstaller-alpine:apline-v3.4-pyinstaller-develop

ENV workdir /pyjsonnet
RUN mkdir -p $workdir
RUN apk --no-cache --update add python py-pip openssl ca-certificates
RUN apk --no-cache --update add --virtual build-dependencies \
      python-dev build-base wget openssl-dev libffi-dev libstdc++

RUN pip install jsonnet

COPY . $workdir
WORKDIR $workdir

RUN pip install -e .

RUN /pyinstaller/pyinstaller.sh --onefile --noconfirm \
    --add-data "pyjsonnet/jsonnet/:pyjsonnet/jsonnet" \
    --onefile \
    --hidden-import _jsonnet \
    --log-level DEBUG \
    --clean \
    bin/jsonnetpy


from alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=0 /pyjsonnet/dist/jsonnetpy /bin

ENTRYPOINT ["/bin/jsonnetpy"]
