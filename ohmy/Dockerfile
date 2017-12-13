FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN mkdir -p /scripts
WORKDIR /scripts

RUN apt-get -qq update  && \
    apt-get install -yq  git \
	net-tools \
    python \
	python-dev \
    python-pip \
    python-yara \
    python3 \
	python-setuptools \
    libboost-python-dev \
    libboost-all-dev \
	build-essential \
	libxml2-dev \
    libxslt-dev \
	libtool \
    automake \
	libffi-dev \
    libfuzzy-dev \
    libjpeg-dev \
    pkg-config \
	autoconf \
    vim \
    nano \
    yara \
    parallel \
    wget \ 
    tcpdump \
    ngrep \
    python3-pip \
    ssdeep \
    wireshark \
    tshark \
    p7zip-full \
    links \
    lynx \
	libcurl4-gnutls-dev \
	librtmp-dev


#RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq wireshark tshark
RUN pip install -U pip
RUN pip install pefile \
    requests \
    bs4 \
    colorama \
    configparser \
    scandir \
    lxml \
    naiveBayesClassifier \
    simplejson \
    openpyxl \
    impacket \
    pyshark \ 
    dpkt \
    pytest \
    geoip2 \
    pyYAML \
    yara-python \
    pyasn \
    python-evtx \
    prettytable \
    psutil \
    pylzma \
    netaddr \
    argparse \
    six \
    python-registry \
	scandir \
	IPy \
	pycurl

RUN pip3 install -U pip
RUN pip3 install pefile \
    python-magic \
    yara-python \
    virustotal-api \
    gitpython \
    pyelftools \
    elasticsearch \
    uuid \
    ssdeep

RUN cp /usr/local/bin/pip2 /usr/local/bin/pip

#ADD GITs
COPY gits.txt /scripts/gits.txt
RUN for i in `cat /scripts/gits.txt`; do git clone $i ; done
RUN mkdir -p /scripts/otx-iocs
COPY get-otx-iocs.py /scripts/otx-iocs/get-otx-iocs.py
RUN python /scripts/linux-soft-exploit-suggester/linux-soft-exploit-suggester.py --update
WORKDIR /scripts/OTX-Python-SDK
RUN python setup.py install
WORKDIR /scripts/yarGen
RUN python yarGen.py --update
WORKDIR /scripts/process-forest
RUN python setup.py install
WORKDIR /scripts/python-evtx
RUN python setup.py install
WORKDIR /scripts/shellbags
RUN python setup.py install
WORKDIR /scripts
#python /scripts/Loki/loki.py --updateRUN python /scripts/Loki/loki.py --update
RUN echo will cite | parallel --bibtex
COPY replace.txt /scripts/SSMA/replace.txt
COPY API_updates.sh /scripts/API_updates.sh
RUN chmod +x /scripts/API_updates.sh
RUN sed -i '69,74d' /scripts/SSMA/ssma.py && \
    sed -i "68r /scripts/SSMA/replace.txt" /scripts/SSMA/ssma.py && \
    sed -i '25,30d' /scripts/SSMA/src/check_virustotal.py && \
    sed -i 's/if args.api_key and internet_connection:/if internet_connection:/g' /scripts/SSMA/ssma.py && \
    sed -i 's/args.api_key and not internet_connection:/not internet_connection:/g' /scripts/SSMA/ssma.py && \
    sed -i 's/virus_check = virustotal(args.filename, args.api_key)/virus_check = virustotal(args.filename, vt_api)/' /scripts/SSMA/ssma.py

ENV HOME /scripts
