FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl \
    sudo \
    nano \
    wget \
    unzip \
    flex \
    libssl-dev \
    git \
    software-properties-common \
    build-essential \
    bc \
    bison \
    pkg-config
    
# Python 3 install
RUN apt-get install -y python3 python3-pip language-pack-en sshpass

# This is to ensure that the host where the docker container is built has the same uid/gid
# as the user used inside the container. Otherwise, permission issues.
ARG HOST_UID

RUN echo 'root:dev' | chpasswd
RUN useradd -ms /bin/bash dev && echo 'dev:dev' | chpasswd && adduser dev sudo
RUN echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /home/dev/.ssh

COPY --chown=dev:dev .devcontainer/scripts/gu /usr/local/bin/gu
COPY --chown=dev:dev .devcontainer/scripts/.bashrc /home/dev/.bashrc
COPY --chown=dev:dev .devcontainer/scripts/ssh_config /home/dev/.ssh/config


# Install the gcc toolchain for compiling the debix kernel
RUN mkdir -p /opt/debix-toolchain
RUN sudo curl "https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz" -o /opt/debix-toolchain/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
RUN tar -xJf /opt/debix-toolchain/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz -C /opt/debix-toolchain


USER dev

# Install and upgrade ansible
RUN python3 -m pip install --user ansible && python3 -m pip install --upgrade --user ansible



