# Compilador cruzado x86_64-elf
FROM randomdude/gcc-cross-x86_64-elf

# Herramientas necesarias para el sistema operativo
RUN apt-get update && apt-get install -y \
    nasm \
    make \
    gcc \
    dosfstools \
    mtools \
    qemu-system-x86 \
    qemu-utils \
    wget \
    xz-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------
# Open Watcom
# ---------------------------------------------------------

ARG OW_VERSION=Current-build
ARG OW_INSTALLER=ow-snapshot.tar.xz

RUN wget -O /tmp/open-watcom.tar.xz \
    https://github.com/open-watcom/open-watcom-v2/releases/download/${OW_VERSION}/${OW_INSTALLER} && \
    mkdir -p /opt/watcom && \
    tar -xf /tmp/open-watcom.tar.xz -C /opt/watcom && \
    rm /tmp/open-watcom.tar.xz

# Variables de entorno de Open Watcom
ENV WATCOM=/opt/watcom
ENV PATH="${WATCOM}/binl64:${WATCOM}/binw:${PATH}"
ENV INCLUDE="${WATCOM}/h"

# Carpeta de trabajo
VOLUME /root/env
WORKDIR /root/env
