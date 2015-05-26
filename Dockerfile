FROM lalyos/scratch-chmx

ADD release/upx /bin/upx
RUN ["/bin/chmx", "/bin/upx"]

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/bin/upx"]
