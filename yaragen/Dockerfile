#
# This Docker image encapsulates the Rekall Memory Forensic Framework (http://www.rekall-forensic.com), 
# Volatility Framework(http://www.volatilityfoundation.org), plaso (https://github.com/log2timeline/plaso/wiki),
# CDQR (https://github.com/rough007/CDQR), TZWorks, dfir_tic script
#
# To run this image after installing Docker, use a command like this:
#
# sudo docker run --rm -it -v /data/cases:/data/cases -v /data/rekall:/rekall/plugins dfir_tic_test:latest /usr/local/bin/dfir_tic.sh -h
#
# Before running the command above, ensure the /data/cases/CASENAME and /data/rekall (contains the rekall profiles expanded)  directories
# make it world-accessible (e.g., "chmod a+xwr /data/rekall /data/cases/CASENAME ").

FROM ubuntu:16.04
MAINTAINER Lenny Zeltser (@lennyzeltser, www.zeltser.com)

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN	apt-get -qq update
RUN apt-get install -qq -y software-properties-common
RUN add-apt-repository -y ppa:gift/stable
RUN apt-get update -qq
RUN apt-get install -qq -y git \
  yara \
  python-dev \
  python-pip

RUN pip install pefile
RUN pip install scandir \
  lxml \
  naiveBayesClassifier 

# INSTALL REKALL and pycoin 
WORKDIR /tmp
RUN git clone https://github.com/Neo23x0/yarGen.git yargen

WORKDIR /tmp/yargen
RUN python yarGen.py --update

RUN groupadd -r dfir && \
  useradd -r -g dfir -d /home/dfir -m -s /sbin/nologin dfir && \
  chown -R dfir:dfir /tmp && \
  echo -e "alias yarGen='python /tmp/yaragen/yarGen.py' \nalias yargen='python /tmp/yaragen/yarGen.py' \nalias yargen.py='python /tmp/yaragen/yarGen.py' \nalias yarGen.py='python /tmp/yaragen/yarGen.py'" >> /home/dfir/.bashrc

USER dfir
