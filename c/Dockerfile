FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --yes tzdata
RUN apt-get install --yes \
    vim \
    build-essential \
    git \
    cmake \
    net-tools \
    gdb \ 
    clang

WORKDIR /app