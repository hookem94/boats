FROM ubuntu:latest
MAINTAINER Xavier Mertens <xavier@rootshell.be>

RUN apt-get update && \
    apt-get install -y git python3-pip python3-selenium chromium-chromedriver python3-pil && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/x0rz/phishing_catcher.git
WORKDIR /opt/phishing_catcher
RUN pip3 install -r requirements.txt

WORKDIR /opt/phishing_catcher
#RUN sed -i "s/env python/env python3/" catch_phishing.py
ENTRYPOINT [ "python3", "./catch_phishing.py" ]
