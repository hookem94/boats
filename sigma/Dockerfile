#
# This Docker image encapsulates the sigma tool

FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN	apt-get -qq update && \
  apt-get install -qq -y git \
  python3 \
  python3-pip 

RUN pip3 install --upgrade pip &&\
  pip3 install pyyaml yara-python


WORKDIR /
RUN git clone https://github.com/Neo23x0/sigma.git
RUN mv /sigma/tools/* /sigma/. && \
  rmdir /sigma/tools

RUN groupadd -r dfir && \
  useradd -r -g dfir -d / -s /sbin/nologin dfir && \
  chown -R dfir:dfir /sigma

WORKDIR /sigma
USER dfir
