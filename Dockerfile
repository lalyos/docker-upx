FROM lalyos/alpine-build:edge AS upx-builder
RUN apk update
RUN apk upgrade
RUN apk add -U zlib-dev xz-dev curl perl p7zip bash

ENV LDFLAGS=-static

ENV UCL_VER 1.03
RUN curl -L http://www.oberhumer.com/opensource/ucl/download/ucl-${UCL_VER}.tar.gz|tar -xzv \
    && cd ucl-${UCL_VER} \
    && ./configure \
# Fix for GCC-6 found here: https://github.com/mxe/mxe/pull/1358/commits/28dd97f3902fcb664c28255a2773839a4a897a2a
       CFLAGS='-std=c90 -fPIC' \
    && make \
    && make install

ENV LZMA_VER 1803
RUN curl -LO http://www.7-zip.org/a/lzma${LZMA_VER}.7z \
    && 7z x lzma${LZMA_VER}.7z
ENV UPX_LZMADIR /

ENV UPX_UCLDIR=/ucl-${UCL_VER}
ENV UPX_VER 3.94
RUN curl -LO https://github.com/upx/upx/releases/download/v${UPX_VER}/upx-${UPX_VER}-src.tar.xz \
    && unxz upx-${UPX_VER}-src.tar.xz  \
    && tar -xvf upx-${UPX_VER}-src.tar \
    && cd upx-${UPX_VER}-src \
    && sed -i "/addLoad/ s/NULL/(char*)NULL/" src/packer.cpp \
    && sed -i.bak -e 's|-print0|-type f -iname "*.o" -prune -o -type f -iname "*.out" -prune -o -print0|' ./src/stub/scripts/check_whitespace.sh \
    && make all

# packs itself
RUN /upx-${UPX_VER}-src/src/upx.out --best --ultra-brute -o/upx /upx-${UPX_VER}-src/src/upx.out

# main container
FROM scratch AS upx
COPY --from=upx-builder /upx /bin/upx
ENTRYPOINT ["upx"]
VOLUME /data
WORKDIR /data